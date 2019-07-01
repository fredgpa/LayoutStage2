function [departments] = adjustPos(departments, dept_number, dir)

    if dir == "up"
        for i = 1:length(departments)
            if (departments(i).sizeD + departments(dept_number).sizeU + 1) == (departments(dept_number).centroidY - departments(i).centroidY) && (departments(dept_number).centroidX == departments(i).centroidX)
                departments = adjustPos(departments, i, dir);
                departments(i).move(dir);
            end
        end
    elseif dir == "right"
        for i = 1:length(departments)
            if (departments(i).sizeL + departments(dept_number).sizeR + 1) == (departments(i).centroidX - departments(dept_number).centroidX) && (departments(dept_number).centroidY == departments(i).centroidY)
                departments = adjustPos(departments, i, dir);
                departments(i).move(dir);
            end
        end
    elseif dir == "down"
        for i = 1:length(departments)
            if (departments(dept_number).sizeD + departments(i).sizeU + 1) == (departments(i).centroidY - departments(dept_number).centroidY) && (departments(dept_number).centroidX == departments(i).centroidX)
                departments = adjustPos(departments, i, dir);
                departments(i).move(dir);
            end
        end
    else
        for i = 1:length(departments)
            if (departments(i).sizeR + departments(dept_number).sizeL + 1) == (departments(dept_number).centroidX - departments(i).centroidX) && (departments(dept_number).centroidY == departments(i).centroidY)
                departments = adjustPos(departments, i, dir);
                departments(i).move(dir);
            end
        end
    end
    
end