import pandas as pd

# Definir o nome do arquivo CSV
input_csv = 'Alfa_IND.csv'

# Ler o arquivo CSV
df = pd.read_csv(input_csv, header=None, names=['filename', 'column1', 'column2'])

# Extrair o valor após o underscore no nome do arquivo
df['category'] = df['filename'].str.extract(r'_(.*?)\.set')

# Iterar sobre cada categoria única e salvar os dados em arquivos CSV separados
for category in df['category'].unique():
    subset = df[df['category'] == category]
    subset.to_csv(f'dados_{category}.csv', index=False, header=False)
