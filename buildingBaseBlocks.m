function [baseBlocks,random] = buildingBaseBlocks(M,K,l,delta)
    
    % costruzione dei blocchi di partenza di dimensione 2*l. Saranno i
    % blocchi di dimensione più piccola.
    % M = numero di blocchi di partenza
    % K = grado più alto a cui tronchiamo la serie di Taylor. 
    % l = lunghezza di metà blocco
    % La funzione calcola per ciascun blocco il suo peso e il suo centroide

    Ni = 2 * l * M; %numero totale di elementi contenuti nei blocchi
    random = randn(1,Ni)*sqrt(delta); %gaussian r.v. N(0,1)
    baseBlocks = zeros(K+1,M); %blocchi base
    baseCentroids = zeros(1,M); %centroidi dei blocchi base
    moment = linspace(0,K,K+1);
    for x = 1:M
        baseCentroids(x) = (2*x - 1) * l;
        for k = moment 
            for i = baseCentroids(x) - l + 1 : baseCentroids(x) + l
                baseBlocks(k+1,x) = baseBlocks(k+1,x) + ((i-baseCentroids(x))/l)^k * random(i);
            end
        end
    end

    baseBlocks = baseBlocks / (2*l);

end
% equation (23)