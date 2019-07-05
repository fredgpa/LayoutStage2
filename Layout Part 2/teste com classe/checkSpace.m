function [ bool ] = checkSpace(departments, dept_number, dir)

    if dir == "up"
        if departments(dept_number).centroidY - departments(dept_number).sizeU > 1
            bool = true;
        else
            bool = false;
        end
    elseif dir == "right"
        if departments(dept_number).centroidX + departments(dept_number).sizeR < 46
            bool = true;
        else
            bool = false;
        end
    elseif dir == "down"
        if departments(dept_number).centroidY + departments(dept_number).sizeD < 22
            bool = true;
        else
            bool = false;
        end
    else
        if departments(dept_number).centroidX - departments(dept_number).sizeL > 1
            bool = true;
        else
            bool = false;
        end
    end
end

