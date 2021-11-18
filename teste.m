if size(instrfind)>0 %Limpa as COM e objetos caso existam
    arduino = instrfind; 
    fclose(arduino); 
    delete(arduino);
    clear arduino;
end
clear all
arduino = serial('COM14'); %cria o objeto arduino
set(arduino,'BaudRate',9600); %velocidade definida no arduino
fopen(arduino); %abre a comunicação
%str = input('Válvula: ','s');
pause(5);
fprintf(arduino,'%s\n','umidade');
out = fscanf(arduino);
umidade=str2double(out);
fprintf(arduino,'%s\n','v1');
str= fscanf(arduino);
fclose(arduino); 
delete(arduino);
clear arduino;