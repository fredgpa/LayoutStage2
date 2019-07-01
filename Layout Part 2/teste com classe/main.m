function [ result ] = main(problem)
    weight_factor = [ 0 0 0 0];
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

    departments(i) = departments(i).updateDir();

    if ~isempty(constraints) && bool
        mod = attract(dept_number, departments, constraints);
    else
        mod = [0 0];
    end

    prob = dirProb(departments, dept_number, mod, bool);

    if departments(dept_number).calcArea == 1
        dir = "right";
    else
        dir = departments(dept_number).directions(roleta(prob));
    end

    
    

end