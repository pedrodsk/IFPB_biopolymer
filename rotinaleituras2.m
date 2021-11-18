%#######################
%# ROTINA DAS LEITURAS #
%#######################
delaywarmup = 300;
delaygas = 30;
delayflush = 90;
delayflushv1 = 30;
if strcmp(str,'v1')
    enviarhex = hex2dec({'FF','FE','02','B9','02'}); %comando para sair do modo sleep.
    fwrite(T6615,enviarhex); %envia para o sensor os bytes do enviarhex
    pause(5);
    enviarhex = hex2dec({'FF','FE','01','84'}); %Warmup.
    fwrite(T6615,enviarhex); %envia para o sensor os bytes do enviarhex
    disp('Warmup')
    %tempo de warmup
    pause(delaywarmup); %warmup
    enviarhex = hex2dec({'FF','FE','01','BD'}); %comando para iniciar as leituras
    fwrite(T6615,enviarhex);
    pause(2);
    flushinput(T6615);
    pause(2);
    umidade='umidade';
    fprintf(arduino,'%s\n',umidade);
    pause(2);
    out =fgetl(arduino);
    umidade=str2double(out);
    tu = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
flushinput(arduino);
pause(2);
fprintf(arduino,'%s\n',str); %envia v1, v2,v3.. para o arduino acionar o reator desejável.
pause(2);
str=fgetl(arduino); % Recebe o valor v1,v2,v3 diretamente do arduino. (confirmação)
sprintf('Reator %s',str)
pause(delaygas);

disp('Leituras')
n1=0;
n=0;
a=0;
readasync(T6615,5);
pause(5);

%Requisita a umidade e hora do sistema

%Leituras
while n1<=0
    while n<20
        
        if T6615.BytesAvailable > 0 %dados disponivel  na serial
            leitura= fread(T6615,5,'uint8'); %leitura = dados do sensor
            pause(3);
            if length(leitura)==5 %tamanho padrão da leitura do sensor 5 bytes
                p1 = dec2hex(leitura(5));  %converte os ultimos 2 bytes para decimal
                p2 = dec2hex(leitura(4));
                s = strcat(p2,p1); %junta os bytes dos dados do ppm 2 bytes
                n=n+1;
                ppm(n) = hex2dec(s); %converte os bytes em decimal
                ppm(n)
                flushinput(arduino);
                fprintf(arduino,'%d\n',ppm(n));
                %stopasync(T6615);
                readasync(T6615,5); %faz uma nova leitura do sensor
                if ppm(n)<280 % se a leitura for menor que 200 ppm, repete a leitura
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
ppmM=0;
ppmM0=0;
while h < 10
    h=h+1;
    ppmM0 = (ppmM0 + ppm(h));
end
ppmM0 = ppmM0/h

while h < 20
    h=h+1;
    ppmM = (ppmM + ppm(h));
end
h=h-10;
ppmM = ppmM/h

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hora só para o txt
t = datetime('now'); %t = data.
t = datestr(t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Grava os valores da média e hora de cada reator em variaveis e envia para
%o arduino
if strcmp(str,'v1')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r1'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1); % Envia para o arduino a média da leitura
    pause(1);
    ppmM0_1 = ppmM0;
    ppmM_1 = ppmM;
    t1 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
    
end
if strcmp(str,'v2')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r2'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_2 = ppmM0;
    ppmM_2 = ppmM;
    t2 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
if strcmp(str,'v3')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r3'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_3 = ppmM0;
    ppmM_3 = ppmM;
    t3 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
if strcmp(str,'v4')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r4'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_4 = ppmM0;
    ppmM_4 = ppmM;
    t4 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
    
end
if strcmp(str,'v5')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r5'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_5 = ppmM0;
    ppmM_5 = ppmM;
    t5 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
    
end
if strcmp(str,'v6')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r6'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_6 = ppmM0;
    ppmM_6 = ppmM;
    t6 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
if strcmp(str,'v7')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r7'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_7 = ppmM0;
    ppmM_7 = ppmM;
    t7 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
if strcmp(str,'v8')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r8'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_8 = ppmM0;
    ppmM_8 = ppmM;
    t8 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
if strcmp(str,'v9')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='r9'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_9 = ppmM0;
    ppmM_9 = ppmM;
    t9 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
    
end
if strcmp(str,'v10')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='s10'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_10 = ppmM0;
    ppmM_10 = ppmM;
    t10 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
    
end
if strcmp(str,'v11')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='t11'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_11 = ppmM0;
    ppmM_11 = ppmM;
    t11 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
    
end
if strcmp(str,'v12')
    ppmM2 = int2str(ppmM); %converte o contador em uma string
    r1='u12'; %string padrao
    r1 = strcat(r1,ppmM2); % concatena as duas strings;
    flushinput(arduino);
    fprintf(arduino,'%s\n',r1);
    pause(1);
    ppmM0_12 = ppmM0;
    ppmM_12 = ppmM;
    t12 = datetime('now','TimeZone','local','Format','yyyy-MM-dd HH:mm:ss');
end
str='b3'; %b3 relé que interrompe a passagem de ar para o sensor (flush)
flushinput(arduino);
fprintf(arduino,'%s\n',str); %envia o b3 para o arduino
pause(2);

str='v1'; %b3 relé que interrompe a passagem de ar para o sensor (flush)
flushinput(arduino);
fprintf(arduino,'%s\n',str); %envia o b3 para o arduino
disp('V1 flush')
pause(delayflushv1);

str='b3'; %b3 relé que interrompe a passagem de ar para o sensor (flush)
flushinput(arduino);
fprintf(arduino,'%s\n',str); %envia o b3 para o arduino
disp('flush')
pause(delayflush);
%     enviarhex = hex2dec({'FF','FE','01','95'}); %Warmup.
%     fwrite(T6615,enviarhex); %envia para o sensor os bytes do enviarhex
%     pause(5); %tempo de flush
%     enviarhex = hex2dec({'FF','FE','01','BD'}); %comando para iniciar as leituras
%     fwrite(T6615,enviarhex);
%     flushinput(T6615);
%     pause(2);