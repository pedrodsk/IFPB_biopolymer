clear all;
a=0;
if size(instrfind)>0 %Limpa as COM e objetos caso existam
    all = instrfindall; 
    fclose(all); 
    delete(all);
    clear all;
end
    %T6615 = serial('COM13'); %cria o objeto
    %set(T6615,'BaudRate',19200); %velocidade definida no sensor
    T6615 = Bluetooth('SAAB', 1);
    fopen(T6615); %abre a comunicação
    pause(3);
    T6615.ReadAsyncMode = 'manual';
    enviarhex = hex2dec({'FF','FE','02','B9','02'}); %comando para sair do modo sleep.
    fwrite(T6615,enviarhex);
    disp('pause 5 min - warmup')
    %pause(300);
    enviarhex = hex2dec({'FF','FE','01','BD'});
    fwrite(T6615,enviarhex);
    flushinput(T6615);
    pause(3);
    n1=0;
    n=0;
    readasync(T6615,5);
    t=datetime();
%pause(10);
while n1<=0
    while n<10000
        
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
                t1=datetime();
%                flushinput(arduino);
%                fprintf(arduino,'%d\n',ppm(n));
                %stopasync(T6615);
                readasync(T6615,5);
                if ppm(n)<350 % se a leitura for menor que 200 ppm, repete a leitura
                    n=n-1;
                else
                    a=a+1;
                    sprintf('%d - PPM: %d',a,ppm(n))
                end
            end
        end
        
    end
    n1=n1+1;
    stopasync(T6615)
end
h=0;
ppmM=0
while h < 400
    h=h+1;
ppmM = (ppmM + ppm(h));
end
ppmM = ppmM/h