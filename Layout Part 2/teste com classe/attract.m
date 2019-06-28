function [ mod ] = attract(dept, departments, constraints)
    
    mod = [0 0];
    attracted_dept = [];
    dept1 = findDepartment(departments, dept);
    for i=1:length(constraints)
        if constraints(i).checkDept(dept)
            if constraints(i).deptA == dept
                dept2 = findDepartment(departments, constraints(i).deptB);
            else
                dept2 = findDepartment(departments, constraints(i).deptA);
            end

            if departments(dept1).centroidX > departments(dept2).centroidX
                if departments(dept1).directions(1) == "up"
                    mod(2) = -1;
                else
                    mod(1) = 1;
                end
            elseif departments(dept1).centroidX < departments(dept2).centroidX                
                if departments(dept1).directions(1) == "up"
                    mod(2) = 1;
                else
                    mod(1) = -1;
                end        
            end

            if departments(dept1).centroidY > departments(dept2).centroidY
                if departments(dept1).directions(1) == "up"
                    mod(2) = 1;
                else
                    mod(1) = 1;
                end
            elseif departments(dept1).centroidY < departments(dept2).centroidY
                if departments(dept1).directions(1) == "up"
                    mod(2) = -1;
                else
                    mod(1) = -1;
                end                
            end
        end
    end
end