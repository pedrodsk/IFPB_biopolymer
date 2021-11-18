% %conn = database('free sql','sql10178425','UldQb9kjnr');
% %sqlquery = 'SELECT * FROM `sql10178425`.`aluno`';
% %curs = exec(conn,sqlquery);
% %curs = fetch(curs);
% %data = curs.Data;
% %close(curs);
% %close(conn);
% a = 21;
% t = datetime('now'); %t = data.
% t = datestr(t);
% b='oii';
% conn = database('Saab Matlab','root','');
% sqlquery = sprintf( 'INSERT INTO `matlab`.`Reator 1` (ppm) VALUES(%d);',a);
% curs = exec(conn,sqlquery);
% close(curs);
% close(conn);
% 
% conn = database('Saab Matlab','root','');
% sqlquery = sprintf('SELECT ppm FROM `matlab`.`Reator 1`;');
% curs = exec(conn,sqlquery);
% curs = fetch(curs);
% curs.Data
% close(curs);
% close(conn);

conn = database('Saab Matlab','root','');
sqlquery = sprintf( 'DROP TABLE `reator 1`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 2`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 3`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 4`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 5`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 6`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 7`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 8`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 9`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 10`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 11`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `reator 12`;');
curs = exec(conn,sqlquery);

sqlquery = sprintf( 'DROP TABLE `umidade`;');
curs = exec(conn,sqlquery);
close(curs);
close(conn);
% 
% DROP TABLE `reator 1`;
% DROP TABLE `reator 2`;
% DROP TABLE `reator 3`;
% DROP TABLE `reator 4`;
% DROP TABLE `reator 5`;
% DROP TABLE `reator 6`;
% DROP TABLE `reator 7`;
% DROP TABLE `reator 8`;
% DROP TABLE `reator 9`;
% DROP TABLE `reator 10`;
% DROP TABLE `reator 11`;
% DROP TABLE `reator 12`;
% DROP TABLE `umidade`;
