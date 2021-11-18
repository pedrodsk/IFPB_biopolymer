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
enviarhex = hex2dec({'FF','FE','01','BD'});
fwrite(T6615,enviarhex);            
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


        
        %enquanto o número de bytes da serial = 0, envia o comando de
        %ler valor do co2 do sensor
        
        %enquanto o número de bytes da serial >0, ler os dados e compara se
        %o tamanho da string é igual a 5, se não for envia o comando de
        %requsição novamente
        while(true)
        if T6615.BytesAvailable > 0
            leitura= fread(T6615,5,'uint8');    
            if length(leitura)==5
                flushinput(T6615);
                p1 = dec2hex(leitura(5)); 
                p2 = dec2hex(leitura(4));
                s = strcat(p2,p1); %junta os bytes dos dados do ppm 2 bytes
                ppm(n) = hex2dec(s); %converte os bytes em decimal
                if ppm(n)<200 % se a leitura for menor que 200 ppm, repete a leitura
                n=n-1;
                end
                if n<0
                n=0;
                end
               ppm
            else
                flushinput(T6615);
                delay(2);
            end
        end
        end