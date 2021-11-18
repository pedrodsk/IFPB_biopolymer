%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abre as comunicações Seriais com os dispositivos e aciona os reatores   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if strcmp(str,'v1') % Reator 1
    disp('conexao serial')
    if size(instrfind)>0 %Limpa as COM e objetos caso existam
        all = instrfindall;
        fclose(all);
        delete(all);
        clear all;
    end
    disp('arduino COM3')
    %try
    %     arduino = serial('COM3'); %cria o objeto arduino
    %     set(arduino,'BaudRate',9600); %baudrate arduino
    arduino = Bluetooth('HC-06', 1);
    fopen(arduino); %abre a comunicação serial o arduino
    pause(3);
    %catch
    %   disp('Porta do Arduino não reconhecida')
    %   dos('reiniciar.bat');
    %end
    %sensor
    disp('telaire')
    % try
    %T6615 = serial('COM5'); %cria o objeto do sensor co2
    %set(T6615,'BaudRate',19200); %baudrate sensor
    %b = instrhwinfo('Bluetooth');
    % b.RemoteNames
    %instrhwinfo('Bluetooth', RemoteName);
    T6615 = Bluetooth('SAAB', 1);
    fopen(T6615); %abre a comunicação
    pause(3);
    
    %catch
    %disp('Porta do sensor não reconhecida')
    %dos('reiniciar.bat');
    %end
    T6615.ReadAsyncMode = 'manual'; %define o modo de comunicação como assíncrono
    
end
