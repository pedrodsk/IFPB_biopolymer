%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%arduino
if strcmp(str,'v1')
if size(instrfind)>0 %Limpa as COM e objetos caso existam
    arduino = instrfind; 
    fclose(arduino); 
    delete(arduino);
    clear arduino;
end
end
arduino = serial('COM3'); %cria o objeto arduino
set(arduino,'BaudRate',9600); %velocidade definida no arduino
fopen(arduino); %abre a comunicação
%str = input('Válvula: ','s');
pause(3);
flushinput(arduino);
fprintf(arduino,'%s\n',str);
pause(0.5);
str=fgetl(arduino);
% while size(str) < [1 1]
% str='v1';
% flushinput(arduino);
% fprintf(arduino,'%s\n',str);
% pause(0.5);
% str=fgetl(arduino)
% end

sprintf('válvula %s',str)
if strcmp(str,'v1')
    umidade='umidade';
    fprintf(arduino,'%s\n',umidade);
    out =fgetl(arduino);
    umidade=str2double(out);
end
fclose(arduino); 
delete(arduino);
clear arduino;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Sensor Co2.
if strcmp(str,'v1')
    if size(instrfind)>0 %Limpa as COM e objetos caso existam
    T6615 = instrfind; 
    fclose(T6615); 
    delete(T6615);
    clear T6615;
    end

    T6615 = serial('COM5'); %cria o objeto
    set(T6615,'BaudRate',19200); %velocidade definida no sensor
    fopen(T6615); %abre a comunicação
    %flushinput(T6615); %zera o buffer
    pause(3);
    %flushinput(T6615); %zera o buffer
    enviarhex = hex2dec({'FF','FE','02','B9','02'}); %comando para sair do modo sleep.
    fwrite(T6615,enviarhex);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
