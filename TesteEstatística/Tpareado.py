import pandas as pd
from scipy.stats import ttest_rel

# Carregar os dados dos arquivos CSV
iboe_df = pd.read_csv('dados_IBOE.csv', header=None, names=['filename', 'column1', 'column2'])
bl01_df = pd.read_csv('dados_BL01.csv', header=None, names=['filename', 'column1', 'column2'])

# Extrair as colunas necessárias para o teste T pareado
iboe_data = iboe_df['column2']
bl01_data = bl01_df['column2']

# Realizar o teste T pareado
t_stat, p_value = ttest_rel(bl01_data, iboe_data)

# Exibir os resultados
print(f'T-statistic: {t_stat}')
print(f'P-value: {p_value}')