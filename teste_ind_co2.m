str = 'v4';

    if size(instrfind)>0 %Limpa as COM e objetos caso existam
    all = instrfindall; 
    fclose(all); 
    delete(all);
    clear all;
    end
    arduino = serial('COM3'); %cria o objeto arduino
    set(arduino,'BaudRate',9600); %velocidade definida no arduino
    fopen(arduino); %abre a comunicação
    pause(3);
    %sensor
    T6615 = serial('COM5'); %cria o objeto
    set(T6615,'BaudRate',19200); %velocidade definida no sensor
    fopen(T6615); %abre a comunicação
    pause(3);
    T6615.ReadAsyncMode = 'manual';
    enviarhex = hex2dec({'FF','FE','02','B9','02'}); %comando para sair do modo sleep.
    fwrite(T6615,enviarhex);
    pause(2);
    enviarhex = hex2dec({'FF','FE','01','BD'});
    fwrite(T6615,enviarhex);
    flushinput(T6615);
    pause(2);
    
     
flushinput(arduino);
fprintf(arduino,'%s\n',str);
pause(1);
str=fgetl(arduino);
sprintf('válvula %s',str)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=0;
%ppm = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
readasync(T6615,5);

while n<=19
        
        if T6615.BytesAvailable > 0
            leitura= fread(T6615,5,'uint8');
            pause(2);
            if length(leitura)==5
                p1 = dec2hex(leitura(5)); 
                p2 = dec2hex(leitura(4));
                s = strcat(p2,p1); %junta os bytes dos dados do ppm 2 bytes
                n=n+1;
                ppm(n) = hex2dec(s); %converte os bytes em decimal
                ppm(n)
                flushinput(arduino);
                fprintf(arduino,'%d\n',ppm(n));
                %pause(1);

                %stopasync(T6615);
                readasync(T6615,5);
                if ppm(n)<200 % se a leitura for menor que 200 ppm, repete a leitura
                    n=n-1;
                end
            end
        end
        
end
    stopasync(T6615)
    
    if size(instrfind)>0 %Limpa as COM e objetos caso existam
    all = instrfindall; 
    fclose(all); 
    delete(all);
    clear all;
    end