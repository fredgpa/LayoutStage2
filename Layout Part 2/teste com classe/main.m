function [ result ] = main(departments, constraints)
    weight_factor = [ 0.00000001 10 10 20 400];
    %%[departments, constraints] = initialize(problem);

    resultsArray = calcObj(departments, contraints, weight_factor);
    it = 1;
    finish = false;
    while(~finish)

        backup = [departments constraints];

        prob = deptProb(departments);

        dept_number = roulette(prob);
        while departments(dept_number).fixedSize == true || departments(dept_number).fixedPos == true
            dept_number = roulette(prob);
        end

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

        if bool
            departments = adjustPos(departments, dept_number, dir);
            departments(dept_number) = departments(dept_number).grow(dir);
            departments(dept_number) = departments(dept_number).center();
        else
            departments(dept_number) = departments(dept_number).shrink(dir);
            departments(dept_number) = departments(dept_number).center();
        end

        resultTemp = calcObj(departments, contraints, weight_factor);
        if resultTemp < resultsArray(length(resultsArray))
            resultsArray = [resultsArray resultTemp];
            it = it + 1;
        else
            departments = backup(1);
            constraints = backup(2);

            finish = true;
            for i=1:length(constraint)
                if (constraint(i).reqAlign && ~(constraint(i).achAlign)) || ~(constraint(i).achAdj)
                    finish = false;
                end
            end
        end
    
    end

end