clear all; %limpar as variaveis

if size(instrfind)>0 %Limpa as COM e objetos caso existam
    all = instrfindall; 
    fclose(all); 
    delete(all);
    clear all;
end

arduino = serial('COM3'); %cria o objeto arduino
set(arduino,'BaudRate',9600); %baudrate arduino
fopen(arduino); %abre a comunicação serial o arduino
pause(2);

flushinput(arduino);
umidade='oi';
fprintf(arduino,'%s\n',umidade);
pause(1);
out =fgetl(arduino)

all = instrfindall; 
fclose(all); 
delete(all);