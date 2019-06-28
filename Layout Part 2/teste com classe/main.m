function [ result ] = main(problem)
    weight_factor = [ 0, 0, 0, 0];
    %%[departments, constraints] = initialize(problem);

    results_array = calcObj(departments, contraints, weight_factor);
    
    %while
    prob = deptProb(departments);
    dept_number = rolette(prob);

    if departments(i).reqArea - departments(i).calcArea() > 0
        bool = true;
    else %% depois testar se isso atrapalha, pois == 0 entra no else
        bool = false;
    end

    if (departments(dept_number).sizeL + departments(dept_number).sizeR + 1) < (departments(dept_number).sizeU + departments(dept_number).sizeD + 1)
        directions = ["up" "down" "right" "left"];
    else
        directions = ["left" "right" "up" "down"];
    end

       bora ver iso



end