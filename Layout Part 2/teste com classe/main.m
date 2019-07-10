function [ result ] = main(departments, constraints, materials, costs)
    weight_factor = [ 0.00000001 10 10 20 400];
    %%[departments, constraints] = initialize(problem);

    [ resultsArray, constraintsArray, areasArray, aspectsArray ]= calcObj(departments, constraints, weight_factor, materials, costs);
    dirArray = [];
    deptArray = [];
    it = 1;
    finish = false;
    while(~finish)
        mod = [0 0];
        resultsArray(length(resultsArray))
        backup.departments = departments;
        backup.constraints = constraints;

        prob = deptProb(departments);

        dept_number = roulette(prob);
        while departments(dept_number).fixedSize == true
            dept_number = roulette(prob);
        end

        if departments(dept_number).reqArea - departments(dept_number).calcArea() > 0
            bool = true;
        else %% depois testar se isso atrapalha, pois == 0 entra no else
            bool = false;
        end

        departments(dept_number) = departments(dept_number).updateDir();
    
        
        if ~isempty(constraints) && bool            
            mod = attract(dept_number, departments, constraints);
        end

        prob = dirProb(departments, dept_number, mod, bool);

        if departments(dept_number).calcArea == 1
            dir = "right";
        else            
            dir = roulette(prob);
            dir = departments(dept_number).directions(dir);
        end
        
        deptArray = [deptArray departments(dept_number).n];
        dirArray = [dirArray dir];

        if bool
            departments = adjustPos(departments, dept_number, dir);
            if checkSpace(departments, dept_number, dir)
                for i=1:length(constraints)
                    if constraints(i).checkDept(departments(dept_number).n) && constraints(i).reqAlign && constraints(i).achAlign
                        if constraints(i).deptA == departments(dept_number).n                            
                            deptPos = findDepartment(departments, deptB);
                        else
                            deptPos = findDepartment(departments, deptA);
                        end
                        if ((dir == "left" || dir == "right") && (departments(dept_number).centroidX == departments(deptPos).centroidX)) || ((dir == "up" || dir == "down") && (departments(dept_number).centroidY == departments(deptPos).centroidY))
                            departments = adjustPos(departments, deptPos, dir);
                            if checkSpace(departments, deptPos, dir)
                                departments(deptPos) = departments(deptPos).grow(dir);
                                departments(deptPos) = departments(deptPos).center();
                            end
                        end
                    end
                end
                departments(dept_number) = departments(dept_number).grow(dir);
                departments(dept_number) = departments(dept_number).center();
            end
        else
            for i=1:length(constraints)
                if constraints(i).checkDept(departments(dept_number).n) && constraints(i).reqAlign && constraints(i).achAlign
                    if constraints(i).deptA == departments(dept_number).n                            
                        deptPos = findDepartment(departments, deptB);
                    else
                        deptPos = findDepartment(departments, deptA);
                    end
                    if ((dir == "left" || dir == "right") && (departments(dept_number).centroidX == departments(deptPos).centroidX)) || ((dir == "up" || dir == "down") && (departments(dept_number).centroidY == departments(deptPos).centroidY))
                            departments(deptPos) = departments(deptPos).shrink(dir);
                            departments(deptPos) = departments(deptPos).center();
                    end
                end
            end
            departments(dept_number) = departments(dept_number).shrink(dir);
            departments(dept_number) = departments(dept_number).center();
        end

        [ resultTemp, constraintValue, areaValue, aspectValue ] = calcObj(departments, constraints, weight_factor, materials, costs);
        if resultTemp <= resultsArray(length(resultsArray))
            resultsArray = [ resultsArray resultTemp ];
            constraintsArray = [ constraintsArray constraintValue ];
            areasArray = [ areasArray areaValue ];
            aspectsArray = [ aspectsArray aspectValue ];
            it = it + 1;
        
        else
            
            if (aspectValue < aspectsArray(length(aspectsArray))) || (areaValue < areasArray(length(areasArray))) || (constraintValue < constraintsArray(length(constraintsArray)))
                resultsArray = [ resultsArray resultTemp ];
                constraintsArray = [ constraintsArray constraintValue ];
                areasArray = [ areasArray areaValue ];
                aspectsArray = [ aspectsArray aspectValue ];
                it = it + 1;
            else
            
                departments = backup.departments;
                constraints = backup.constraints;

                finish = true;
                for i=1:length(constraints)
                    if (constraints(i).reqAlign && ~(constraints(i).achAlign)) || ~(constraints(i).achAdj)
                        finish = false;
                    end
                end
            end
        end
        

    end
    result = [ resultsArray deptArray dirArray ];
end