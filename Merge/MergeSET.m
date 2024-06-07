% Limpar Workspace
clear;
close all;
clc;

% Adicionar o diretório do EEGLAB ao path do MATLAB, se necessário
%eeglab_path = 'caminho/para/o/EEGLAB';
%addpath(eeglab_path);

% Carregar EEGLAB
eeglab;

% Definir o diretório onde os arquivos .set estão localizados
diretorio = 'C:\Users\dhyeg\OneDrive\Dhyego\Mestrado\Matlab\Scripts\EDF_Rose\SET\Merge\Bloco2.3\001';

% Listar arquivos .set no diretório
arquivos_set = dir(fullfile(diretorio, '*.set'));
num_arquivos = length(arquivos_set);

if num_arquivos < 2
    error('Pelo menos dois arquivos .set são necessários para unificar.');
end

% Carregar o primeiro arquivo .set
EEG = pop_loadset('filename', arquivos_set(1).name, 'filepath', diretorio);

% Loop para unir os demais arquivos .set
for i = 2:num_arquivos
    arquivo_atual = fullfile(diretorio, arquivos_set(i).name);
    EEG_tmp = pop_loadset('filename', arquivos_set(i).name, 'filepath', diretorio);
    EEG = pop_mergeset(EEG, EEG_tmp, 1);
end

% Salvar o arquivo unificado como .set
arquivo_unificado = '001_BL23.set';
pop_saveset(EEG, 'filename', arquivo_unificado, 'filepath', diretorio);

disp('Arquivos .set unificados e salvos com sucesso.');
