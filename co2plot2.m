conn = database('Saab Matlab','root','');
i=0;
sqlquery = sprintf('SELECT id FROM `matlab`.`Reator 12` WHERE id >= 1 AND id <=8 ;');
    x = exec(conn,sqlquery);
    x = fetch(x);
    x = cell2mat(x.Data);
while i<12
    
    i=i+1; %contador
    iS = int2str(i); %converte o contador em uma strin
    sqlquery = sprintf('SELECT ppm FROM `matlab`.`Reator %s` WHERE id >= 1 AND id <= 8;',iS);
    y = exec(conn,sqlquery);
    y = fetch(y);
    y=y.Data;
    v{i} = cell2mat(y);
    %close(conn);
end
 figure
 %scatter(x,v1)
 plot(x,v{1},'-s',x,v{2},'-s',x,v{3},'-s',x,v{4},'-s',x,v{5},'-s',x,v{6},'-s',x,v{7},'-s',x,v{8},'-s',x,v{9},'-s',x,v{10},'-s',x,v{11},'-s',x,v{12},'-s')
 %stem(v{1},'-s',v{2},'-s',v{3},'-s',v{4},'-s',v{5},'-s',v{6},'-s',v{7},'-s',v{8},'-s',v{9},'-s',v{10},'-s',v{11},'-s',v{12},'-s')
 
 title('Concentração de co2')
 xlabel('Amostra:')
 ylabel('PPM')
 legend('show')
 legend('Reator 1','Reator 2','Reator 3','Reator 4','Reator 5','Reator 6','Reator 7','Reator 8','Reator 9','Reator 10','Reator 11','Reator 12')
 