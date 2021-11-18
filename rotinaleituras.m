%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ROTINA DAS LEITURAS

n1=0;
n=0;
ppm = [0 0 0 0 0 0 0 0 0 0];
while n1<=0
    while n<=9
        %enquanto o número de bytes da serial = 0, envia o comando de
        %ler valor do co2 do sensor
        flushinput(T6615);
        while T6615.BytesAvailable == 0
            enviarhex = hex2dec({'FF','FE','02','02','03'});
            fwrite(T6615,enviarhex);
            pause(2); %pausa dos intervalos das leituras
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
                n=n+1;
                ppm(n) = hex2dec(s); %converte os bytes em decimal
                ppm(n)
                if ppm(n)<200 % se a leitura for menor que 200 ppm, repete a leitura
                    n=n-1;
                end
            else    
                enviarhex = hex2dec({'FF','FE','02','02','03'});
                fwrite(T6615,enviarhex);
                pause(2);
            end
        end
        
    end
    n1=n1+1;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%