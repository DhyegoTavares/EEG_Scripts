import pandas as pd
import os

path = '/home/dhyego/Documentos/EEG_Scripts/anova_files'



def excel_to_csv(sheet_name, csv_file):

    for file in os.listdir(path):
        df = pd.read_excel(os.path.join(path, file), sheet_name=sheet_name)
        df.drop(columns=['Grupo'], inplace=True)
        df.to_csv(f"{file.split('.')[0]}.csv", index=False)


# Exemplo de uso
sheet_name = 'Planilha1'  # Substitua pelo nome da planilha que deseja converter
csv_file = 'saida.csv'  # Substitua pelo caminho do arquivo CSV de saída

excel_to_csv(sheet_name, csv_file)
