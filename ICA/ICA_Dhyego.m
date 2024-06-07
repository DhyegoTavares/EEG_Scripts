%Script para colocar as localizações dos canais ,

clear all

pastaDados= 'C:\Users\dhyeg\Desktop\ica\'; %pasta onde estão os dados

arq=dir([pastaDados, '*.edf']); %Pega os arquivos set na pastaDados
tamanho=length(arq); %diz qtos arquivos tem na pasta
mkdir([pastaDados 'SET\']);
for i=1:tamanho
    
    disp(arq(i).name);
    EEG = pop_biosig([pastaDados arq(i).name], 'importevent','off','blockepoch','off','importannot','off');
    EEG = pop_select( EEG,'nochannel',{'M1','M2','Cb2','Cb1','VEOG','HEOG','EMG','EKG','Fz','FT11','F11','F12','FT12'});%excluindo%
    %EEG = pop_select( EEG,'nochannel',{'M1' 'M2' 'VEOG' 'HEOG' 'EMG' 'EKG','FZ','FT11','F11','F12','FT12'});%excluindo Yago%
    %-------------------alteração feita por Yago em 01/10/2023-------------
    %EEG = pop_reref(EEG, []);
    %----------------------------------------------------------------------
    EEG = pop_eegfiltnew(EEG, 'locutoff',0.5,'hicutoff',50);
    EEG=pop_chanedit(EEG, 'lookup','C:\Users\dhyeg\OneDrive\Dhyego\Mestrado\Matlab\Scripts\standard_1005.elc'); %Caminho do arquivo standard_1005.elc
    EEG.etc.eeglabvers = '2023.1'; % this tracks which version of EEGLAB is being used, you may ignore it
    EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on','pca',55);
    EEG = pop_subcomp( EEG, [1  2  3  4], 0);
    EEG = eeg_checkset( EEG );
    
    EEG = pop_saveset( EEG, 'filename',arq(i).name,'filepath',[pastaDados 'SET\']);
end

disp ('FIM')
