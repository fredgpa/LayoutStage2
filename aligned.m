function [ answer ] = aligned(departments, constraints, dept, dir)
    answer = [];
    adjacent_departments = [];
    for i = 1:length(constraints)
            if constraints(i).deptA == dept.n && constraints(i).achAdj
                adjacent_departments = [ adjacent_departments findDepartment(departments, constraints(i).deptB) ];
            elseif constraints(i).deptB == dept.n && constraints(i).achAdj
                adjacent_departments = [ adjacent_departments findDepartment(departments, constraints(i).deptA) ];
            end
    end
    
    if ~isempty(adjacent_departments)
        for i = 1:length(adjacent_departments)
            if dir == "up" && (dept.centroidY - dept.sizeU) == (departments(adjacent_departments(i)).centroidY + departments(adjacent_departments(i)).sizeD)
                answer = [answer adjacent_departments(i)];
            elseif dir == "right" && (dept.centroidX - dept.sizeL) == (departments(adjacent_departments(i)).centroidX + departments(adjacent_departments(i)).sizeR)
                answer = [answer adjacent_departments(i)];
            elseif dir == "down" && (dept.centroidY + dept.sizeD) == (departments(adjacent_departments(i)).centroidY - departments(adjacent_departments(i)).sizeU)
                answer = [answer adjacent_departments(i)];
            elseif dir == "left" && (dept.centroidX + dept.sizeR) == (departments(adjacent_departments(i)).centroidX - departments(adjacent_departments(i)).sizeL)
                answer = [answer adjacent_departments(i)];
            end
        end
    end
end