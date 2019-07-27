function [ prob ] = deptProb(departments)
    
    n = length(departments);
    area_diff = zeros(1, n);
    prob = zeros(1, n);
    total_area_diff = 0;
    for i=1:n
        area_diff(i) = abs(departments(i).reqArea - departments(i).calcArea());
        total_area_diff = total_area_diff + area_diff(i);
    end

    for i=1:n
        if total_area_diff ~= 0
            prob(i) = area_diff(i)/total_area_diff;
        else
            prob = zeros(1, n);
            break;
        end
    end
end