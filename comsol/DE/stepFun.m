function result = stepFun(thrs, value)
    [i_max, j_max] = size(value);
    result = zeros(i_max, j_max);
    for i=1:i_max
        for j=1:j_max
            if(value(i,j) >= thrs)
                result(i,j) = 1;
            end
        end
    end
end