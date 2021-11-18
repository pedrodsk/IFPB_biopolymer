%configuracoes.
if size(instrfind)>0 %Limpa as COM e objetos caso existam
T6615 = instrfind; 
fclose(T6615); 
delete(T6615);
clear T6615;
end

T6615 = serial('COM9'); %cria o objeto
set(T6615,'BaudRate',19200); %velocidade definida no sensor
fopen(T6615); %abre a comunicação
flushinput(T6615); %zera o buffer
pause(2);
enviarhex = hex2dec({'FF','FE','02','B9','02'});
fwrite(T6615,enviarhex);
flushinput(T6615);
pause(15);            
 n = 0; %inicializa a variavel de repetições para as médias
 n1=0; %inicializa a variavel de repetições de médias.
 
 %busca o indice do ultimo experimento no arquivo,
 sizeA = [2 inf];
 fileID = fopen('C:\Users\Pedro\Google Drive\Pedro\ifpb\software\sensor1.txt','r','n','UTF-8');
 A = fscanf(fileID,'%d %f',sizeA);
 fclose(fileID);
 if size(A) == 0;
 A=0;
 end
  B=A(1,:);
 %C=A(2,:);
 x=B(end);
 
ppm = [0 0 0 0 0 0 0 0 0 0];

while n1<=10
    while n<=9
        n=n+1;
        %se n = 1, envia o comando de sair do modo standby do sensor
        if n==1
            
        end
        %enquanto o número de bytes da serial = 0, envia o comando de
        %ler valor do co2 do sensor
        while T6615.BytesAvailable == 0
            enviarhex = hex2dec({'FF','FE','02','02','03'});
            fwrite(T6615,enviarhex);
            clc;
            pause(2);
        end
        %enquanto o número de bytes da serial >0, ler os dados e compara se
        %o tamanho da string é igual a 5, se não for envia o comando de
        %requsição novamente
        while T6615.BytesAvailable > 0
            leitura= fread(T6615,5,'uint8');    
            if length(leitura)==5
                flushinput(T6615);
                p1 = dec2hex(leitura(5)); 
                p2 = dec2hex(leitura(4));
                s = strcat(p2,p1); %junta os bytes dos dados do ppm 2 bytes
                ppm(n) = hex2dec(s); %converte os bytes em decimal
                ppm(n)
                if ppm(n)<200 % se a leitura for menor que 200 ppm, repete a leitura
                    n=n-1;
                    if n<0
                        n=0;
                    end
                end
            else    
                enviarhex = hex2dec({'FF','FE','02','02','03'});
                fwrite(T6615,enviarhex);
                pause(2);
            end
        end
        
        
        
    end
ppmM = (ppm(1)+ppm(2)+ppm(3)+ppm(4)+ppm(5)+ppm(6)+ppm(7)+ppm(8)+ppm(9)+ppm(10))/10 %média dos valores ppm
x = x+1; 
t = datetime('now'); %t = data.
t = datestr(t);
fileID = fopen('C:\Users\Pedro\Google Drive\Pedro\ifpb\software\sensor1.txt','a+');
fprintf(fileID,'%d %f\r\n',x,ppmM); %grava o valor da medida e da média no arquivo sensor1
fclose(fileID);
clear ppmM;
clear ppm;
fileID = fopen('C:\Users\Pedro\Google Drive\Pedro\ifpb\software\tempo.txt','a+');
fprintf(fileID,'%s\r\n',t); %grava a váriavel tempo em outro arquivo.
fclose(fileID);
sizeA = [2 inf];
fileID = fopen('C:\Users\Pedro\Google Drive\Pedro\ifpb\software\sensor1.txt','r','n','UTF-8');
A = fscanf(fileID,'%d %f',sizeA);
fclose(fileID);
Mi = A(1,:); % separa os valores dos index em uma matrix Mi
Mppm = A(2,:); % separa os valores ppm na matriz Mppm
sizeA = [19 inf];
fileID = fopen('C:\Users\Pedro\Google Drive\Pedro\ifpb\software\tempo.txt','r','n','UTF-8');
A = fscanf(fileID,'%s',sizeA);
Mt = A'; % separa os valores das datas na matriz Mt
fclose(fileID);
% grava as três matrizes em um novo arquivo.
fileID = fopen('C:\Users\Pedro\Google Drive\Pedro\ifpb\software\teste.txt','a+');
fprintf(fileID,'#############  %d  #############\r\n\n',Mi(:,x));
fprintf(fileID,'%s\r\n',Mt(x,:));
fprintf(fileID,'%f\r\n',Mppm(:,x));
fprintf(fileID,'################################\r\n\n');

n1=n1+1; %incrementa o n das médias
n = 0; %zera o n das medidas parciais para novo loop
end
%envia o comando de standby
enviarhex = hex2dec({'FF','FE','02','B9','01'});
fwrite(T6615,enviarhex);