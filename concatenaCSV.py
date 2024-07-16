import pandas as pd
import os

path = '/home/dhyego/Documentos/EEG_Scripts/csv_files'
def concatenate_csv():
    df2 = pd.DataFrame()
    for file in os.listdir(path):
        wave = file.split('_')[0]
        df = pd.read_csv(os.path.join(path,file))
        df.insert(loc=6, column='wave', value=wave)
        df2 = pd.concat([df2,df])
        df2.to_csv('concatenated.csv',index=False)

concatenate_csv()