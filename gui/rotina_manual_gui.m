% app.Bluetooth1EditField.Value = app.bt1;
% app.Bluetooth2EditField.Value = app.bt2;
% app.WarmupEditField.Value = app.delaywarmup;
% app.DelayGasEditField.Value = app.delaygas;
% app.DelayFlushEditField.Value = app.delayflush;
% app.DelayFlushv1EditField.Value = app.delayflushv1;

if size(instrfind)>0 %Limpa as COM e objetos caso existam
    all = instrfindall;
    fclose(all);
    delete(all);
end
    arduino = Bluetooth(app.bt2, 1);
    T6615 = Bluetooth(app.bt1, 1);
out = instrfind;
if strcmp(out.Status(1),'closed')
    app.Status.Value='Inicializando Bluetooth do Controlador..';
    fopen(arduino); %abre a comunicação serial o arduino
    pause(3);
    out = instrfind;
end
if strcmp(out.Status(2),'closed')
    app.Status.Value='Inicializando Bluetooth do Sensor Co2..';
    fopen(T6615);
    pause(3);
    out = instrfind;
    T6615.ReadAsyncMode = 'manual';
    enviarhex = hex2dec({'FF','FE','02','B9','02'}); %comando para sair do modo sleep.
    fwrite(T6615,enviarhex); %envia para o sensor os bytes do enviarhex
    pause(5);
    enviarhex = hex2dec({'FF','FE','01','BD'}); %comando para iniciar as leituras
    fwrite(T6615,enviarhex);
    pause(2);
    flushinput(T6615);
    pause(2);
end
app.Status.Value='Iniciando Leituras..';
n=0;
a=0;
readasync(T6615,5);
pause(5);
while n<400
    
    if app.r1==1
    fprintf(arduino,'%s\n','v1');
    app.r1=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r2==1
    fprintf(arduino,'%s\n','v2');
    app.r2=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r3==1
    fprintf(arduino,'%s\n','v3');
    app.r3=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r4==1
    fprintf(arduino,'%s\n','v4');
    app.r4=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r5==1
    fprintf(arduino,'%s\n','v5');
    app.r5=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r6==1
    fprintf(arduino,'%s\n','v6');
    app.r6=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r7==1
    fprintf(arduino,'%s\n','v7');
    app.r7=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r8==1
    fprintf(arduino,'%s\n','v8');
    app.r8=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r9==1
    fprintf(arduino,'%s\n','v9');
    app.r9=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r10==1
    fprintf(arduino,'%s\n','v10');
    app.r10=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r11==1
    fprintf(arduino,'%s\n','v11');
    app.r11=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
    if app.r12==1
    fprintf(arduino,'%s\n','v12');
    app.r12=0;
    a=0;
    ppm=0;
    n=0;
    valor=0;
    vetorx=0;
    end
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
                app.Status.Value=sprintf('%d - PPM: %d',a,ppm(n));
                
                vetorx(a) = a;
                app.ydata=ppm;
                stem(app.UIAxes,app.ydata);
                valor= num2str(ppm(n));
                
                ppmtxt = ppm+1;
                %text(app.UIAxes,vetorx,ppmtxt,valor,'HorizontalAlignment','center','Color','red','FontSize',12)
            end
        end
    end
    
end
stopasync(T6615)
fprintf(arduino,'%s\n','b3');
