function [fBm] = fBm_Rambaldi1994(H,L,delta)
    tic();
    l = 1; %metà lunghezza di un blocco
    M = floor(L/2); %numero di blocchi elementari, un blocco elementare è lungo 2*l
    
    K = 8; %numero di momenti ai quali tronco la serie di Taylor
    moment = linspace(0,K,K+1); %conto anche il momento nullo
    
    [baseBlocks,xi] = buildingBaseBlocks(M,K,l,delta); %creiamo un blocco finale in più
    lengthBlocks = [2*l];
    centroids = [l];
    valueBlocks = [baseBlocks(:,1)];
    fBm = zeros(2*l*M,1);

    for j = 2*l+1 : 2*l * (M)
        
        for x = 1:length(centroids)
            
            sumOfMoments = 0;
            for k = 0:K
                
                sumOfMoments = sumOfMoments + (-lengthBlocks(x)*0.5/(j-centroids(x)+1))^k *fattH(H-0.5,k)*valueBlocks(k+1,x);
                %valueBlocks(k+1,x)
            end
            
            fBm(j) = fBm(j) + lengthBlocks(x)*(j-centroids(x)+1)^(H-0.5) * sumOfMoments;
            
        end 

        if(mod(j,2*l) == 0)
            [lengthBlocks,centroids,valueBlocks] = update(lengthBlocks,centroids,valueBlocks,baseBlocks,j,l,xi);

        end
    end
    toc();
    plot(fBm','-')
end
