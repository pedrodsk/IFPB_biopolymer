T6615 = serial('COM9');
set(T6615,'BaudRate',19200)
fopen(T6615)
enviarhex = hex2dec({'FF','FE','04','00','11','22','33'});
fwrite(T6615,enviarhex);
idn = fscanf(T6615);
fprintf('%X',idn)
T6615 = instrfind;
fclose(T6615);
delete(T6615);
clear T6615;


% a =hex2dec('ff');
% b =hex2dec('fe');
% c =hex2dec('02');
% d =hex2dec('b9');
% e =hex2dec('02');
% f =hex2dec('fffe02b902');
