function [departments] = adjustPos(departments, dept_number, dir)

    if dir == "up"
        for i = 1:length(departments)
            if (departments(dept_number).centroidY > departments(i).centroidY) && (i ~= dept_number) && (departments(i).sizeD + departments(dept_number).sizeU + 1) == (departments(dept_number).centroidY - departments(i).centroidY) && ((departments(dept_number).centroidX - departments(dept_number).sizeL <= departments(i).centroidX + departments(i).sizeR) && (departments(dept_number).centroidX + departments(dept_number).sizeR >= departments(i).centroidX - departments(i).sizeL)) && (departments(i).fixedPos == false)
                departments = adjustPos(departments, i, dir);
                if checkSpace(departments, i, dir)
                    departments(i) = departments(i).move(dir);
                end
            end
        end
    elseif dir == "right"
        for i = 1:length(departments)
            if (departments(dept_number).centroidX < departments(i).centroidX) && (i ~= dept_number) && (departments(i).sizeL + departments(dept_number).sizeR + 1) == (departments(i).centroidX - departments(dept_number).centroidX) && ((departments(dept_number).centroidY - departments(dept_number).sizeU <= departments(i).centroidY + departments(i).sizeD) && (departments(dept_number).centroidY + departments(dept_number).sizeD >= departments(i).centroidY - departments(i).sizeU)) && (departments(i).fixedPos == false)
                departments = adjustPos(departments, i, dir);
                if checkSpace(departments, i, dir)
                    departments(i) = departments(i).move(dir);
                end
            end
        end
    elseif dir == "down"
        for i = 1:length(departments)
            if (departments(dept_number).centroidY < departments(i).centroidY) && (i ~= dept_number) && (departments(dept_number).sizeD + departments(i).sizeU + 1) == (departments(i).centroidY - departments(dept_number).centroidY) && ((departments(dept_number).centroidX - departments(dept_number).sizeL <= departments(i).centroidX + departments(i).sizeR) && (departments(dept_number).centroidX + departments(dept_number).sizeR >= departments(i).centroidX - departments(i).sizeL)) && (departments(i).fixedPos == false)
                departments = adjustPos(departments, i, dir);
                if checkSpace(departments, i, dir)
                    departments(i) = departments(i).move(dir);
                end
            end
        end
    else
        for i = 1:length(departments)
            if (departments(dept_number).centroidX > departments(i).centroidX) && (i ~= dept_number) && (departments(i).sizeR + departments(dept_number).sizeL + 1) == (departments(dept_number).centroidX - departments(i).centroidX) && ((departments(dept_number).centroidY - departments(dept_number).sizeU <= departments(i).centroidY + departments(i).sizeD) && (departments(dept_number).centroidY + departments(dept_number).sizeD >= departments(i).centroidY - departments(i).sizeU)) && (departments(i).fixedPos == false)
                departments = adjustPos(departments, i, dir);
                if checkSpace(departments, i, dir)
                    departments(i) = departments(i).move(dir);
                end
            end
        end
    end
    
end