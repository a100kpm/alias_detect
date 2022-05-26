import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.callbacks import TensorBoard, ModelCheckpoint

from data_manip import *

def neural_model(List=[64,128,256,128,64],drop=0.2,LR=0.001,input_size=23):
    model = Sequential()
    model.add(Dense(List[0], input_shape=(input_size,),activation='relu'))
    model.add(Dropout(drop))

    for i in range(1,len(List)):
        model.add(Dense(List[i], activation='relu'))
        model.add(Dropout(drop))
    
    model.add(Dense(1, activation='sigmoid'))
    
    learning_rate = LR
    opt = tf.keras.optimizers.Adam(lr=learning_rate,decay=1e-6)
#    init=tf.global_variables_initializer() #sometimes needed to fix a bug that would otherwise need kernel reset, when several models are created
    model.compile(loss='mean_squared_error',optimizer=opt,metrics=['accuracy'])
              
    return model


def test(model,data_Test):
    lenn=len(data_Test)
    score=0
    for i in range(lenn):
        val=model.predict(np.array([data_Test[i][1:]]))
        if val<0.5:
            val=0
        else:
            val=1
        
        if val==data_Test[i][0]:
            score+=1
    print('score=',score,'/',lenn)
    return score,lenn





#data1 = legit data, data2= fake data
data1=np.load('data11_generated.npy') #data11 was saved as data1 without duplicate of the [0]*23 vector
data2=np.load('data2_generated.npy')

normalyze_List=normalyze_factor_table(data1,data2)
data1,data2=normalyze_data(data1,data2,normalyze_List)
data_Train,data_Test=shuffle_data(data1,data2)
X,Y=create_data_for_model(data_Train)

dataX=[x[1:] for x in data_Test]
dataY=[x[0] for x in data_Test]
dataX=np.array([dataX])
size1,size2=np.shape(dataX)[1:3]
dataX=np.reshape(dataX,[size1,size2])


def roc_testing(model,val,dataX,dataY):
    lenn=len(dataX)
    score1=0
    score2=0
    score3=0
    score4=0
    for i in range(lenn):
        if model.predict(np.array([dataX[i]]))<=val:
            temp=0
            if temp==dataY[i]:
                score1+=1
            else:
                score3+=1
        else:
            temp=1
            if temp==dataY[i]:
                score2+=1
            else:
                score4+=1
    print(score1,score2,score3,score4,lenn)


#testing various models on a few epochs
List_model=[]
List_model.append([512,256,128,64,32])
List_model.append([32,64,128,256,512])
List_model.append([360,180,90,45,24])
List_model.append([24,45,90,180,360])
List_model.append([1024,512,256,128,64])
List_model.append([64,128,256,512,1024])
List_model.append([400,200,100,50,25,13])
List_model.append([128,256,512,256,128])
List_model.append([13,25,50,100,200,400])

List_LR=[]
List_LR.append(1)
List_LR.append(0.1)
List_LR.append(0.01)
List_LR.append(0.001)
List_LR.append(0.0001)
List_LR.append(0.00001)
List_LR.append(0.000001)
List_LR.append(0.0000001)

result=[]
result_border=[]

for models in range(len(List_model)):
    for learning_rate in range(len(List_LR)):
        model=neural_model(List=List_model[models],LR=List_LR[learning_rate])
        NAME = f"models_n°-{models}---learning-{learning_rate}"
        tensorboard = TensorBoard(log_dir=f'logs/{NAME}')
        filepath= "FINALE-{epoch:02d}"
        checkpoint = ModelCheckpoint("models/{}.model".format(filepath))
        history = model.fit(x=np.array(X),y=Y,epochs=10,validation_split=0.2,batch_size=64,callbacks=[tensorboard,checkpoint])
        val,_=test(model,data_Test)
        
        result.append(val)