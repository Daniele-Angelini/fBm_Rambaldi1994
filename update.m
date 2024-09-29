function [newLength,centroids,valueBlocks] = update(lengthBlocks,centroids,valueBlocks,baseBlocks,j,l,xi)

    newPosition = j+1; %position at the future step
    newBlockPosition = floor(newPosition/(2*l)); %block number
    %adding new base block
    lengthBlocks(end+1) = 2*l;
    centroids(end+1) = centroids(end) + 2*l;
    valueBlocks(:,end+1) = baseBlocks(:,newBlockPosition);
    K = length(valueBlocks(:,1));
    newLength = [];
    
    if length(lengthBlocks) ~= 2
        v = lengthBlocks;

        while true
            found = false;
            n = length(v);
            for i = n:-1:3
                if v(i) == v(i-1) && v(i-1) == v(i-2)
                    v(i-2) = v(i-2) + v(i-1);
                    v(i-1) = [];
                    centroids(i-2) = (centroids(i-2) + centroids(i-1))/2;
                    centroids(i-1) = [];
                    valueBlocks(:,i-2) = neighborhoodBlocks(centroids(i-2),xi,v(i-2),K);
                    valueBlocks(:,i-1) = [];
                    found = true; 
                    break;
                end
            end
            if ~found
                break;
            end
        end
        newLength = v;
    else
        newLength = lengthBlocks;
    end

end