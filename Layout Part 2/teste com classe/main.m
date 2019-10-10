function [ result ] = main(departments, constraints, materials, costs, cromossome)
    %exemplo de cromossomo para 5 pesos e 20 departamentos
    %[5 10 15 11 14 17 20 3 4 5 8 7 9 6 1 2 11 10 13 12 16 15 14 18 17 19 20 1 5 4 3 7 7 8 9 6 3 8 7 9 6 4 2 4 1 5 2 5 6...]
    % primeiro o numero de pesos, depois os pesos, depois o numero de depts, depois os depts e os centroids em seguida
    weight_factor = cromossome(2:(cromossome(1)+1));
    %%[departments, constraints] = initialize(problem);

    departments = updateDepartments(departments, cromossome);

    %{
    for i = 1:length(departments)
        departments(i) = departments(i).updateFlowPoint();
    end
    %}
    [ resultsArray, flowArray, departments, constraints ]= calcObj(departments, constraints, weight_factor, materials, costs);
    dirArray = [];
    deptArray = [];
    allResults = [];
    sizesArray = [];
    %it = 638;
    it = 1;
    finish = false;
    

    dept_number = cromossome(1) + 3;
    while(~finish)
        
        mod = [0 0];
        resultsArray(length(resultsArray))
        backup.departments = departments;
        backup.constraints = constraints;



        if dept_number <= 25 && (departments(dept_number).reqArea - departments(dept_number).calcArea() == 0)
            dept_number = dept_number + 1;
        end
        
        %{
        prob = deptProb_Area(departments);

        if sum(prob) == 0
            break;
        end
        dept_number = roulette(prob);
        while departments(dept_number).fixedSize == true
            dept_number = roulette(prob);
        end
        %}

        if departments(dept_number).reqArea - departments(dept_number).calcArea() > 0
            bool = true;
        else %% depois testar se isso atrapalha, pois == 0 entra no else
            bool = false;
        end

        departments(dept_number) = departments(dept_number).updateDir();
    
        
        if ~isempty(constraints) && bool            
            [ departments, mod ] = attract(dept_number, departments, constraints);
        end
       

        prob = dirProb(departments, dept_number, mod, bool);
        %
        if departments(dept_number).calcArea == 1
            dir = "right";
        else
        %
            dir = roulette(prob);
            dir = departments(dept_number).directions(dir);
        end
        
            
        if bool
            departments = adjustPos(departments, constraints, dept_number, dir);
            if checkSpace(departments, dept_number, dir)
                for i=1:length(constraints)
                    if constraints(i).checkDept(departments(dept_number).n) && constraints(i).reqAlign && constraints(i).achAlign
                        if constraints(i).deptA == departments(dept_number).n                            
                            deptPos = findDepartment(departments, constraints(i).deptB);
                        else
                            deptPos = findDepartment(departments, constraints(i).deptA);
                        end
                        if ((dir == "left" || dir == "right") && (departments(dept_number).centroidX == departments(deptPos).centroidX)) || ((dir == "up" || dir == "down") && (departments(dept_number).centroidY == departments(deptPos).centroidY))
                            departments = adjustPos(departments, constraints, deptPos, dir);
                            if checkSpace(departments, deptPos, dir)
                                departments(deptPos) = departments(deptPos).grow(dir);
                                departments(deptPos) = departments(deptPos).center();
                            end
                        end
                    end
                end
                %
                departments(dept_number) = departments(dept_number).grow(dir);
                departments(dept_number) = departments(dept_number).center();
            end
        else
            %
            for i=1:length(constraints)
                if constraints(i).checkDept(departments(dept_number).n) && constraints(i).reqAlign && constraints(i).achAlign
                    if constraints(i).deptA == departments(dept_number).n                            
                        deptPos = findDepartment(departments, constraints(i).deptB);
                    else
                        deptPos = findDepartment(departments, constraints(i).deptA);
                    end
                    if ((dir == "left" || dir == "right") && (departments(dept_number).centroidX == departments(deptPos).centroidX)) || ((dir == "up" || dir == "down") && (departments(dept_number).centroidY == departments(deptPos).centroidY))
                            departments(deptPos) = departments(deptPos).shrink(dir);
                            departments(deptPos) = departments(deptPos).center();
                    end
                end
            end
            %
            departments(dept_number) = departments(dept_number).shrink(dir);
            departments(dept_number) = departments(dept_number).center();
        end

        %departments(dept_number) = departments(dept_number).updateFlowPoint();
        
        [ resultTemp, flowTemp, departments, constraints ] = calcObj(departments, constraints, weight_factor, materials, costs);
        
        deptArray = [deptArray; departments(dept_number).n];
        dirArray = [dirArray; dir];
        allResults = [ allResults; resultTemp ];
        sizesArray = [ sizesArray; (departments(dept_number).sizeU + departments(dept_number).sizeD) (departments(dept_number).sizeL + departments(dept_number).sizeR)];
        
        if resultTemp <= resultsArray(length(resultsArray)) %&& flowTemp <= flowArray(length(flowArray))
            resultsArray = [ resultsArray resultTemp ];
            flowArray = [ flowArray flowTemp ];
            it = it + 1;        
        else
            %
            aux = it/6000;
            %{
            if aux > 0.095
                aux = 0.095;
            end
            %}
            if rand() < (0.1 - aux) && abs(resultsArray(length(resultsArray)) - resultTemp) < (0.1*resultsArray(length(resultsArray)))
                resultsArray = [ resultsArray resultTemp ];
                flowArray = [ flowArray flowTemp ];
                it = it + 1;
            else
                departments = backup.departments;
                constraints = backup.constraints;
                %
                if length(resultsArray) > 20
                    if resultsArray((length(resultsArray) - floor(0.2*it)):length(resultsArray)) == resultsArray(length(resultsArray))
                        finish = true;
                    %{
                        for i=1:length(constraints)
                            if (constraints(i).reqAlign && ~(constraints(i).achAlign)) || ~(constraints(i).achAdj)
                                finish = false;
                            end
                        end
                    %}
                    end
                end
                %
            end
        end

    end
    result.resultsArray = resultsArray;
    result.deptArray = deptArray;
    result.dirArray = dirArray;
    result.departments = departments;
    result.constraints = constraints;
    result.allResults = allResults;
    result.sizesArray = sizesArray;

    
end