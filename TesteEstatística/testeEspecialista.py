import pandas as pd
import scipy.stats as stats
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

dataDelta = {
    'BL01': [-6.598828,-1.495706,-2.099758,2.961852,-2.053175,0.110749,0.333398],
    'BL02': [-7.602081,-0.241282,0.23416,3.404967,-1.543926,0.911402,-0.265193],
    'BL03': [0.007234,-0.487962,0.18013,3.398979,-0.771996,0.588423,0.142021],
    'BL04': [-1.300736,-2.656407,-2.9363,1.187939,-0.222387,-0.339661,-0.212942]
}

dataBeta = {
    'BL01': [-0.624786,0.057048,1.161853,4.490162,-2.348169,-1.292759,-0.124146],
    'BL02': [9.276571,5.113219,3.127831,2.356583,13.845636,8.395421,6.58337],
    'BL03': [9.276571,5.113219,3.127831,2.356583,13.845636,8.395421,6.58337],
    'BL04': [9.276571,5.113219,3.127831,2.356583,13.845636,8.395421,6.58337]
}

dataTheta = {
    'BL01': [-5.54345,0.458863,-0.931273,3.16733,-1.651984,-0.606725,0.050645],
    'BL02': [-6.46073,0.845146,0.058084,3.051876,-1.547601,0.129889,-0.044875],
    'BL03': [0.266397,0.992905,0.027819,3.127324,-0.574045,0.534132,0.662531],
    'BL04': [-1.034652,-0.439093,-1.209791,1.888133,0.084557,-0.464225,0.464121]
}

dataAlpha = {
    'BL01': [-3.798004, 6.059843, 2.582436, 4.508273, -1.44684, 0.298265, 2.279972],
    'BL02': [-3.929847, 5.498966, 2.986723, 4.478414, -1.053383, 0.697549, 1.896387],
    'BL03': [2.166668, 6.0756, 3.258145, 4.594411, -0.300351, 0.977196, 2.431377],
    'BL04': [0.633106, 5.366982, 2.24243, 3.528272, 0.166321, 0.461914, 2.959968]
}



# Criando os boxplots para cada conjunto de dados
fig, axes = plt.subplots(1, 4, figsize=(20, 5))

for i, (title, data) in enumerate(zip(['Delta', 'Theta', 'Alpha', 'Beta'], [dataDelta, dataTheta, dataAlpha, dataBeta])):
    df = pd.DataFrame(data)
    ax = axes[i]
    sns.boxplot(data=df, ax=ax)
    ax.set_title(title)
    ax.set_xlabel('BL')
    ax.set_ylabel('Valores')

plt.tight_layout()
plt.show()

# Realizando o teste de normalidade (Shapiro-Wilk) para dataDelta como exemplo
df = pd.DataFrame(dataDelta)
normality_results = {col: stats.shapiro(df[col]) for col in df.columns}

# Exibindo os resultados do teste de normalidade
for col, result in normality_results.items():
    print(f'{col}: p-value = {result.pvalue}')
