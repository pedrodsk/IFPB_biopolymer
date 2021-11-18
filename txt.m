%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Criação dos arquivos txt 
x = x+1;
fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\sensor%sppm.txt',str),'a+');
fprintf(fileID,'%d %f\r\n',x,ppmM); %grava o valor da medida e da média no arquivo sensor1
fclose(fileID);
fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\tempo%s.txt',str),'a+');
fprintf(fileID,'%s\r\n',t); %grava a váriavel tempo em outro arquivo.
fclose(fileID);
sizeA = [2 inf];
fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\sensor%sppm.txt',str),'r','n','UTF-8');
A = fscanf(fileID,'%d %f',sizeA);
fclose(fileID);
Mi = A(1,:); % separa os valores dos index em uma matrix Mi
Mppm = A(2,:); % separa os valores ppm na matriz Mppm
sizeA = [19 inf];
fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\tempo%s.txt',str),'r','n','UTF-8');
A = fscanf(fileID,'%s',sizeA);
Mt = A'; % separa os valores das datas na matriz Mt
fclose(fileID);
% grava as três matrizes em um novo arquivo.
fileID = fopen(sprintf('C:\\Users\\Pedro\\Google Drive\\Pedro\\ifpb\\software\\dados\\%s.txt',str),'a+');
fprintf(fileID,'#############  %d  #############\r\n\n',Mi(:,x));
if strcmp(str,'v1')
    fprintf(fileID,'Umidade: %d\r\n',umidade);
end
fprintf(fileID,'Data: %s\r\n',Mt(x,:));
fprintf(fileID,'PPM: %f\r\n',Mppm(:,x));
fprintf(fileID,'################################\r\n\n');
fclose(fileID);
fclose('all');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
str='b3';
fprintf(arduino,'%s\n',str);
pause(2);