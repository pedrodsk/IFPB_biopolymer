m=0;
if size(instrfind)>0 %Limpa as COM e objetos caso existam
arduino = instrfind; 
fclose(arduino); 
delete(arduino);
clear arduino;
end
arduino = serial('COM3'); %cria o objeto
set(arduino,'BaudRate',9600); %velocidade definida no arduino
fopen(arduino); %abre a comunicação

while m==0
str = input('Gostaria de acionar: ','s');
    if str == '0'
        m=1;
        
    end
fprintf(arduino,'%s\n',str);
out = fgetl(arduino);
out2=str2double(out);
m=1;
end
arduino = instrfind; 
fclose(arduino); 
delete(arduino);
clear arduino;
