function [result] = fattH(H,k)
    flag=1;
    for i = 0:k-1
        flag = flag * (H-i);
    end
    result = (flag)/factorial(k);
end