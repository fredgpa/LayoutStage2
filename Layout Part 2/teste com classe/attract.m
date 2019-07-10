function [ departments, mod ] = attract(dept_number, departments, constraints)
    
    mod = [0 0];
    attracted_dept = [];
    dept1 = dept_number;
    for i=1:length(constraints)
        if constraints(i).checkDept(departments(dept_number).n) && (~constraints(i).achAdj || (constraints(i).reqAlign && ~constraints(i).achAlign))
            if constraints(i).deptA == departments(dept_number).n
                dept2 = findDepartment(departments, constraints(i).deptB);
            else
                dept2 = findDepartment(departments, constraints(i).deptA);
            end

            if departments(dept1).centroidX > departments(dept2).centroidX
                %{
                departments = adjustPos(departments, dept1, "left");
                if checkSpace(departments, dept_number, "left")
                    departments(dept1) = departments(dept1).move("left");
                end
                %}                
                if departments(dept1).directions(1) == "up"
                    mod(2) = mod(2) - 1;
                else
                    mod(1) = mod(1) + 1;
                end
            elseif departments(dept1).centroidX < departments(dept2).centroidX
                %{
                departments = adjustPos(departments, dept1, "right");
                if checkSpace(departments, dept_number, "right")
                    departments(dept1) = departments(dept1).move("right");
                end
                %}
                if departments(dept1).directions(1) == "up"
                    mod(2) = mod(2) + 1;
                else
                    mod(1) = mod(1) - 1;
                end        
            end

            if departments(dept1).centroidY > departments(dept2).centroidY
                %{
                departments = adjustPos(departments, dept1, "up");
                if checkSpace(departments, dept_number, "up")
                    departments(dept1) = departments(dept1).move("up");
                end
                %}
                if departments(dept1).directions(1) == "up"
                    mod(1) = mod(1) + 1;
                else
                    mod(2) = mod(2) + 1;
                end
            elseif departments(dept1).centroidY < departments(dept2).centroidY
                %{
                departments = adjustPos(departments, dept1, "down");
                if checkSpace(departments, dept_number, "down")
                    departments(dept1) = departments(dept1).move("down");
                end
                %}
                if departments(dept1).directions(1) == "up"
                    mod(1) = mod(1) - 1;
                else
                    mod(2) = mod(2) - 1;
                end                
            end
        end
    end
    
    if mod(1) > 1
        mod(1) = 1;
    elseif mod(1) < -1
        mod(1) = -1;
    end
    
    if mod(2) > 1
        mod(2) = 1;
    elseif mod(2) < -1
        mod(2) = -1;
    end
end