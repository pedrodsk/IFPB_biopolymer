cd 'C:\Users\Pedro\Google Drive\Pedro\ifpb\software' %mudar para padrão
clear all; % limpar todas as variaveis 
addpath('C:\Users\Pedro\Google Drive\Pedro\ifpb\software'); %adicionar o path
javaaddpath 'C:\Users\pedro\Google Drive\Pedro\ifpb\software\sqljdbc_6.0\enu\jre7\sqljdbc41.jar'
%###################################################################
% Executa as rotinas do software individualmente para cada Reator  #
%###################################################################

ME = []; %cria a matriz de tratamento de erro

try %tratamento de erro
    
%arquivos % rotina que cria os arquivos txt sem apagar os conteúdos.
%arquivosDEL % rotina que cria os arquivos txt apagando os conteudos (deixar coment.)

i=0; %contador para os reatores 
i2=0;%contador da quantidade de medidas (0 padrão)
    while i2<1
        %##########################################################################################    
        %#Este laço é responsável pela comutação dos reatores e chamada das rotinas dos programas.#
        %##########################################################################################
        while i<12 
            i=i+1; %contador
            iS = int2str(i); %converter o contador em uma string
            str='v'; %string padrao
            str = strcat(str,iS); % concatena as duas strings;
            %rotina - "programas separados"
            serialco22 % executa a rotina matlab de configurações seriais
            %indice %executa a rotina matlab de busca do indice do txt (sem sql)
            rotinaleituras2 %executa a rotina das leituras do co2
            %txt %executa a rotina de exportar os dados para o txt
            
            %flush no reator 1
            %str='v1';
            %fprintf(arduino,'%s\n',str);
            %pause(30);
                        
        end
        i2 = i2+1; %incrementa i2
        i=0; %zera i
    end
    standby2 %executa a rotina de finalização, responsável por gravar os valores no BD e standby do sensor
catch ME %caso haja algum erro na execução do laço, ME != 0
end
if ~isempty(ME) %caso haja algum erro no try, executar o reiniciar.bat
   disp('reiniciar')
   dos('reiniciar.bat');
end