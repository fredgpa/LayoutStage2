function [ bool ] = checkSpace(departments, dept_number, dir)
    bool = true;
    if dir == "up"
        if departments(dept_number).centroidY - departments(dept_number).sizeU > 1
            for i = 1:length(departments)
                if (departments(dept_number).centroidY > departments(i).centroidY) && (i ~= dept_number) && (departments(i).sizeD + departments(dept_number).sizeU + 1) == abs(departments(dept_number).centroidY - departments(i).centroidY) && (departments(dept_number).centroidX - departments(dept_number).sizeL <= departments(i).centroidX + departments(i).sizeR) && (departments(dept_number).centroidX + departments(dept_number).sizeR >= departments(i).centroidX - departments(i).sizeL)
                    bool = false;
                end
            end         
        else
            bool = false;
        end
    elseif dir == "right"
        if departments(dept_number).centroidX + departments(dept_number).sizeR < 46
            for i = 1:length(departments)
                if (departments(dept_number).centroidX < departments(i).centroidX) && (i ~= dept_number) && (departments(i).sizeL + departments(dept_number).sizeR + 1) == abs(departments(dept_number).centroidX - departments(i).centroidX) && (departments(dept_number).centroidY - departments(dept_number).sizeU <= departments(i).centroidY + departments(i).sizeD) && (departments(dept_number).centroidY + departments(dept_number).sizeD >= departments(i).centroidY - departments(i).sizeU)
                    bool = false;
                end
            end         
        else
            bool = false;
        end
    elseif dir == "down"
        if departments(dept_number).centroidY + departments(dept_number).sizeD < 22
            for i = 1:length(departments)
                if (departments(dept_number).centroidY < departments(i).centroidY) && (i ~= dept_number) && (departments(i).sizeU + departments(dept_number).sizeD + 1) == abs(departments(dept_number).centroidY - departments(i).centroidY) && (departments(dept_number).centroidX - departments(dept_number).sizeL <= departments(i).centroidX + departments(i).sizeR) && (departments(dept_number).centroidX + departments(dept_number).sizeR >= departments(i).centroidX - departments(i).sizeL)
                    bool = false;
                end
            end         
        else
            bool = false;
        end
    else
        if departments(dept_number).centroidX - departments(dept_number).sizeL > 1
            for i = 1:length(departments)
                if (departments(dept_number).centroidX > departments(i).centroidX) && (i ~= dept_number) && (departments(i).sizeR + departments(dept_number).sizeL + 1) == abs(departments(dept_number).centroidX - departments(i).centroidX) && (departments(dept_number).centroidY - departments(dept_number).sizeU <= departments(i).centroidY + departments(i).sizeD) && (departments(dept_number).centroidY + departments(dept_number).sizeD >= departments(i).centroidY - departments(i).sizeU)
                    bool = false;
                end
            end 
        else
            bool = false;
        end
    end
end

