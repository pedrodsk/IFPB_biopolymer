%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %busca o indice do ultimo experimento no arquivo,
 sizeA = [2 inf];
 fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\sensor%sppm.txt',str),'r','n','UTF-8');
 A = fscanf(fileID,'%d %f',sizeA);
 fclose(fileID);
 if size(A) == 0;
 A=0;
 end
  B=A(1,:);
 %C=A(2,:);
 x=B(end);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
