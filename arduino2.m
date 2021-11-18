if size(instrfind)>0 %Limpa as COM e objetos caso existam
arduino = instrfind; 
fclose(arduino); 
delete(arduino);
clear T6615;
end
arduino = serial('COM5'); %cria o objeto
set(arduino,'BaudRate',9600); %velocidade definida no sensor
fopen(arduino); %abre a comunicação
flushinput(arduino); %zera o buffer
pause(2);
fprintf(arduino,'%s','pedro');