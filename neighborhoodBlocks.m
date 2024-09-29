function [newBlock] = neighborhoodBlocks(cT,xi,L,K)

    %dati due blocchi adiacenti, essi vengono uniti formandone uno nuovo
    %M1 = valore del blocco 1 (per ogni momento k)
    %c1 = centroide del blocco 1
    %M2 = valore del blocco 2 (per ogni momento k)
    %c2 = centroide del blocco 2
    %L = lunghezza dei blocchi (che varia nel tempo aggregando i blocchi)
    
    moment = linspace(0,K-1,K);
    newBlock = zeros(K,1);
    R = floor(L/2);

    for k = moment
        for i = cT - R + 1 : cT + R
            newBlock(k+1) = newBlock(k+1) + ((i-cT)/R)^k * xi(i);
        end
    end

    % for k = moment
    %     flag1 = 0;
    %     flag2 = 0;
    %     for l = 0:k
    %         flag1 = flag1 + nchoosek(k,l) * c1^l * M1(k+1-l);
    %         flag2 = flag2 + nchoosek(k,l) * c2^l * M2(k+1-l);
    %     end
    %     newBlock(k + 1) = flag1 + flag2;
    % end
     newBlock = newBlock / (2*R);
end
%equation (27)