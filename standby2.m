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