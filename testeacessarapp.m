ME = []; %cria a matriz de tratamento de erro
try %tratamento de erro
    %arquivos % rotina que cria os arquivos txt sem apagar os conteúdos.
    %arquivosDEL % rotina que cria os arquivos txt apagando os conteudos (deixar coment.)
    i=0; %contador para os reatores
    i2=0;%contador da quantidade de medidas (0 padrão)
    while i2<1
        %##########################################################################################
        %#Este laço é responsável pela comutação dos reatores e chamada das rotinas dos programas.#
        %##########################################################################################
        while i<12
            i=i+1; %contador
            iS = int2str(i); %converter o contador em uma string
            str='v'; %string padrao
            str = strcat(str,iS); % concatena as duas strings;
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
            %fim do serial.
            %#######################
            %# ROTINA DAS LEITURAS #
            %#######################
            delaywarmup = 7;
            delaygas = 7;
            delayflush = 7;
            delayflushv1 = 7;
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
            %fim do rotinaleitras
        end
        i2 = i2+1; %incrementa i2
        i=0; %zera i
    end
    %################################################################################################
    %# Envia o comando de standby do sensor e grava os valores da média e hora de cada reator no BD #
    %################################################################################################
    flushinput(T6615);
    pause(2);
    enviarhex = hex2dec({'FF','FE','02','B9','01'});
    fwrite(T6615,enviarhex);
    pause(2);
    flushinput(arduino);
    fprintf(arduino,'%s\n',t);
    pause(2);
    str='fim';
    flushinput(arduino);
    fprintf(arduino,'%s\n',str);
    pause(2);
    if size(instrfind)>0 %Limpa as COM e objetos caso existam
        all = instrfindall;
        fclose(all);
        delete(all);
        clear all;
    end
    % Envia as variaveis para o BD no final das rotinas
    conn = database('Saab Matlab','root','');
    sqlquery = sprintf( 'INSERT INTO `matlab`.`umidade` (umidade,hour) VALUES(%d,"%s");',umidade,tu);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 1` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_1,ppmM_1,t1);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 2`(ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_2,ppmM_2,t2);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 3`(ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_3,ppmM_3,t3);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 4` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_4,ppmM_4,t4);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 5` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_5,ppmM_5,t5);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 6` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_6,ppmM_6,t6);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 7` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_7,ppmM_7,t7);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 8` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_8,ppmM_8,t8);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 9` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_9,ppmM_9,t9);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 10` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_10,ppmM_10,t10);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 11` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_11,ppmM_11,t11);
    curs = exec(conn,sqlquery);
    
    sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 12` (ppm0,ppm,hour) VALUES(%.2f,%.2f,"%s");',ppmM0_12,ppmM_12,t12);
    curs = exec(conn,sqlquery);
    
    close(curs);
    close(conn);
    disp('FIM')
catch ME %caso haja algum erro na execução do laço, ME != 0
end
if ~isempty(ME) %caso haja algum erro no try, executar o reiniciar.bat
    disp('reiniciar')
    %dos('reiniciar.bat');
end