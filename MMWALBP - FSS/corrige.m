function corrigida = corrige(S, M)
    %S: Sequência a ser corrigida
    [~,nt]=size(M);
    PS = zeros(1, nt); % Sequência correta
    Mp = M;
    j = 0;
    i = 1;

    while j < nt
        a = S(i);
        if (Mp(nt+1,a) == 0) && (ismember(a,PS) ~= 1)
            j = j+1;
            PS(j) = a;
            for k = 1:nt
                if Mp(a,k) == 1
                    Mp(a,k) = 0;
                    Mp(nt+1,k) = Mp(nt+1,k)-1;
                end;
            end;
        end;
        i = i+1;
        if i > nt
            i = 1;
        end;
    end;
    corrigida = PS;
end
