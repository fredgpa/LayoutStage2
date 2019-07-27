function [ result ] = main2(departments, constraints, materials, costs)
    finish = false;
    directions = ["up" "right" "down" "left"];
    weight_factor = [ 0.00000001 10 10 20 400];
    [ resultsArray, ~, departments, constraints ] = calcObj(departments, constraints, weight_factor, materials, costs);
    while(~finish)
        backup.departments = departments;
        backup.constraints = constraints;
        
        prob = deptProb_Flow(departments, materials);
        
        dept_number = roulette(prob);
        
        prob = dirProb_Flow(departments, dept_number, materials);
        dir = roulette(prob);
        
        departments = adjustPos(departments, constraints, dept_number, directions(dir));
        if checkSpace(departments, dept_number, directions(dir))
            adjacent_departments = aligned(departments, constraints, departments(dept_number), directions(dir));
            departments(dept_number) = departments(dept_number).move(directions(dir));
            while(~isempty(adjacent_departments))
                departments = adjustPos(departments, constraints, adjacent_departments(1), directions(dir));
                adjacent_departments = [ adjacent_departments aligned(departments, constraints, departments(adjacent_departments(1)), directions(dir)) ];
                if checkSpace(departments, adjacent_departments(1), directions(dir))
                    departments(adjacent_departments(1)) = departments(adjacent_departments(1)).move(directions(dir));
                end
                adjacent_departments(1) = [];                
            end
                
            for i=1:length(constraints)
                if constraints(i).checkDept(departments(dept_number).n) && constraints(i).reqAlign && constraints(i).achAlign
                    if constraints(i).deptA == departments(dept_number).n
                        deptPos = findDepartment(departments, constraints(i).deptB);
                    else
                        deptPos = findDepartment(departments, constraints(i).deptA);
                    end
                    if ((directions(dir) == "left" || directions(dir) == "right") && (departments(dept_number).centroidX == departments(deptPos).centroidX)) || ((directions(dir) == "up" || directions(dir) == "down") && (departments(dept_number).centroidY == departments(deptPos).centroidY))
                        departments = adjustPos(departments, constraints, deptPos, directions(dir));
                        if checkSpace(departments, deptPos, directions(dir))
                            departments(deptPos) = departments(deptPos).move(directions(dir));
                        end
                    end
                end
            end            
        end
        
        [ resultTemp, ~, departments, constraints ] = calcObj(departments, constraints, weight_factor, materials, costs);
        resultTemp
        if resultTemp <= resultsArray(length(resultsArray))
            resultsArray = [ resultsArray resultTemp];
        else
            departments = backup.departments;
            constraints = backup.constraints;
            [ resultTemp, ~, departments, constraints ] = calcObj(departments, constraints, weight_factor, materials, costs);
            resultsArray = [ resultsArray resultTemp];
            if length(resultsArray) > 10
                if resultsArray((length(resultsArray) - 10):length(resultsArray)) == resultsArray(length(resultsArray))
                    finish = true;
                end
            end
        end
    end
    
    result.resultsArray = resultsArray;
    result.departments = departments;
    result.constraints = constraints;
end