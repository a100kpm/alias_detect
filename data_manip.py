import pandas as pd
import numpy as np
import random



def generate_new_legit_data(data,num=100):
    """
    generate small noise on the data (data augmentation)
    """
    lenn1=np.shape(data)[0]
    lenn2=np.shape(data)[1]
    new_data=[]
    for k in range(num):
        for i in range(lenn1):
            new_data=np.copy(data[i])
            for j in range(lenn2):
                val=random.randrange(1,10001)/10000
                if new_data[j]-val>0:
                    new_data[j]-=val
            new_data=new_data.reshape(1,24)
            data=np.append(data,new_data,axis=0)
        
    return data


def format_data(filename,cheat=0):
    """
    reformat data and save them to disk, cheat=0 for legit, cheat=1 for fake
    """
    data=pd.read_csv(filename)
    data=data.drop(['id','match_id','player_id'],axis=1)
#    data=data.drop_duplicates()
    
    if cheat==0:
        for i in data.index.values:
            data.at[i,'flag_global']=0
        data.to_csv('reformated_data1.csv',index=False, encoding='utf8')
    elif cheat==1:
        for i in data.index.values:
            data.at[i,'flag_global']=1
        data.to_csv('reformated_data2.csv',index=False, encoding='utf8')

def get_formated_data(filename):
    data=pd.read_csv(filename)
    return data.values


def normalyze_factor_table(data1,data2):
    """
    get normalyzing factor of the dataset
    """
    data=np.append(data1,data2,axis=0)
    lenn=len(data[0])
    normalyze_List=[0 for x in data[0][1:]]
    
    for i in data:
        for j in range(1,lenn):
            if i[j]>normalyze_List[j-1]:
                normalyze_List[j-1]=i[j]
    return normalyze_List
    
def normalyze_data(data1,data2,normalyze_List):
    """
    normalyzing the data set
    """
    lenn=len(normalyze_List)
    lenn1=len(data1)
    for i in range(lenn1):
        for j in range(1,lenn+1):
            if normalyze_List[j-1]!=0:
                data1[i][j]=data1[i][j]/normalyze_List[j-1]
                
    lenn2=len(data2)
    for i in range(lenn2):
        for j in range(1,lenn+1):
            if normalyze_List[j-1]!=0:
                data2[i][j]=data2[i][j]/normalyze_List[j-1]
                
    return data1,data2


#data1 and data2 are respectively legit and fake data
def shuffle_data(data1,data2,apprentissage=0.7):
    """
    shuffle data and split into train and test set
    apprentissage->0-1 where value is % of train size/total size
    """
    np.random.shuffle(data1)
    np.random.shuffle(data2)
    len1=len(data1)
    len2=len(data2)
    data_Train0=data1[0:int(len1*apprentissage)]
    data_Train1=data2[0:int(len2*apprentissage)]
    
    data_Test0=data1[int(len1*apprentissage):]
    data_Test1=data2[int(len2*apprentissage):]
    
    data_Train=np.append(data_Train0,data_Train1,axis=0)
    data_Test=np.append(data_Test0,data_Test1,axis=0)
    
    np.random.shuffle(data_Train)
    np.random.shuffle(data_Test)
    
    return data_Train,data_Test      


def create_data_for_model(data):
    """
    split data / target
    """
    Y=[x[0] for x in data]
    X=[x[1:] for x in data]
    
    return X,Y

