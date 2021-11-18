%co2 plot
clear all;
i=0;
while i<12
    i=i+1; %contador
    iS = int2str(i); %converte o contador em uma string
    str='v'; %string padrao
    str = strcat(str,iS); % concatena as duas strings;
    sizeA = [2 inf];
    fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\sensor%sppm.txt',str),'r','n','UTF-8');
    A = fscanf(fileID,'%d %f',sizeA);
    x=A(1,:);
    %sprintf('%s',str)
    v{i}=A(2,:);
    fclose(fileID);
end
 figure
 %scatter(x,v1)
 plot(x,v{1},'-s',x,v{2},'-s',x,v{3},'-s',x,v{4},'-s',x,v{5},'-s',x,v{6},'-s',x,v{7},'-s',x,v{8},'-s',x,v{9},'-s',x,v{10},'-s',x,v{11},'-s',x,v{12},'-s')
 title('Concentração de co2')
 xlabel('Amostra:')
 ylabel('PPM')
 legend('show')
 legend('Reator 1','Reator 2','Reator 3','Reator 4','Reator 5','Reator 6','Reator 7','Reator 8','Reator 9','Reator 10','Reator 11','Reator 12')