if size(instrfind)>0 %Limpa as COM e objetos caso existam
    all = instrfindall; 
    fclose(all); 
    delete(all);
    end