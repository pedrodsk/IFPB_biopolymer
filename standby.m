if size(instrfind)>0 %Limpa as COM e objetos caso existam
    T6615 = instrfind; 
    fclose(T6615); 
    delete(T6615);
    clear T6615;
    end

    T6615 = serial('COM15'); %cria o objeto
    set(T6615,'BaudRate',19200); %velocidade definida no sensor
    fopen(T6615); %abre a comunicação
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%envia o comando de standby
enviarhex = hex2dec({'FF','FE','02','B9','01'});
fwrite(T6615,enviarhex);
pause(1);
flushinput(T6615);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(instrfind)>0 %Limpa as COM e objetos caso existam
T6615 = instrfind; 
fclose(T6615); 
delete(T6615);
clear T6615;
end

arduino = serial('COM14'); %cria o objeto arduino
set(arduino,'BaudRate',9600); %velocidade definida no arduino
fopen(arduino); %abre a comunicação
%str = input('Válvula: ','s');
pause(3);
str='fim';
fprintf(arduino,'%s\n',str);

if size(instrfind)>0 %Limpa as COM e objetos caso existam
    arduino = instrfind; 
    fclose(arduino); 
    delete(arduino);
    clear arduino;
end
