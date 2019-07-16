function [details] = details(result)

    for i = 1:length(result.departments)
        details(result.departments(i).n, 1) = result.departments(i).reqArea;
        details(result.departments(i).n, 2) = result.departments(i).calcArea;
        details(result.departments(i).n, 3) = result.departments(i).reqAspect;
        details(result.departments(i).n, 4) = result.departments(i).calcAspect;
    end
end

