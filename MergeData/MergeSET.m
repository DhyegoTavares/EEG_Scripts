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
diretorio = 'D:\Experimento\SemMusica\8';

% Listar arquivos .set no diretório
arquivos_set = dir(fullfile(diretorio, '*.set'));
num_arquivos = length(arquivos_set);

if num_arquivos < 2
    error('Pelo menos dois arquivos .set são necessários para unificar.');
end

% Canais a serem removidos
canais_para_remover = {'Status', 'trigger'};

% Carregar o primeiro arquivo .set
EEG = pop_loadset('filename', arquivos_set(1).name, 'filepath', diretorio);

% Remover canais especificados, se existirem
labels_atuais = {EEG.chanlocs.labels};
idx_remover = find(ismember(lower(labels_atuais), lower(canais_para_remover)));
if ~isempty(idx_remover)
    EEG = pop_select(EEG, 'nochannel', idx_remover);
end

% Loop para unir os demais arquivos .set
for i = 2:num_arquivos
    EEG_tmp = pop_loadset('filename', arquivos_set(i).name, 'filepath', diretorio);
    
    % Remover canais especificados, se existirem
    labels_tmp = {EEG_tmp.chanlocs.labels};
    idx_remover_tmp = find(ismember(lower(labels_tmp), lower(canais_para_remover)));
    if ~isempty(idx_remover_tmp)
        EEG_tmp = pop_select(EEG_tmp, 'nochannel', idx_remover_tmp);
    end

    % Unir com o principal
    EEG = pop_mergeset(EEG, EEG_tmp, 1);
end

% Salvar o arquivo unificado como .set
arquivo_unificado = '008.set';
pop_saveset(EEG, 'filename', arquivo_unificado, 'filepath', diretorio);

disp('Arquivos .set unificados e salvos com sucesso.');
