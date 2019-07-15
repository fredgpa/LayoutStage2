classdef Constraint
    properties 
        deptA = [];
        deptB = [];
        reqAlign = [];
        achAlign = [];
        achAdj = [];
    end
    methods
        function obj = constraintCheck(obj, deptA, deptB)
            deptA = deptA.center;
            deptB = deptB.center;
            distX_Y = sqrt((deptA.centroidX - deptB.centroidX)^2 + (deptA.centroidY - deptB.centroidY)^2);
            diagonalA = sqrt((deptA.sizeR)^2 + (deptA.sizeD)^2);
            diagonalB = sqrt((deptB.sizeR)^2 + (deptB.sizeD)^2);
            
            if deptA.sizeR >= deptA.sizeD
                biggest_side_A = deptA.sizeR;
            else
                biggest_side_A = deptA.sizeD;
            end
            
            if deptB.sizeR >= deptB.sizeD
                biggest_side_B = deptB.sizeR;
            else
                biggest_side_B = deptB.sizeD;
            end
            
            if (deptA.centroidY > deptB.centroidY) && (deptB.sizeD + deptA.sizeU) == abs(deptA.centroidY - deptB.centroidY) && (deptA.centroidX - deptA.sizeL <= deptB.centroidX + deptB.sizeR) && (deptA.centroidX + deptA.sizeR >= deptB.centroidX - deptB.sizeL)
                %up
                obj.achAdj = true;
                if deptA.centroidX + deptA.sizeR == deptB.centroidX + deptB.sizeR && deptA.centroidX - deptA.sizeL == deptB.centroidX - deptB.sizeL
                    obj.achAlign = true;
                else
                    obj.achAlign = false;
                end
            elseif (deptA.centroidX < deptB.centroidX) && (deptB.sizeL + deptA.sizeR) == abs(deptA.centroidX - deptB.centroidX) && (deptA.centroidY - deptA.sizeU <= deptB.centroidY + deptB.sizeD) && (deptA.centroidY + deptA.sizeD >= deptB.centroidY - deptB.sizeU)
                %right
                obj.achAdj = true;
                if deptA.centroidY + deptA.sizeD == deptB.centroidY + deptB.sizeD && deptA.centroidY - deptA.sizeU == deptB.centroidY - deptB.sizeU
                    obj.achAlign = true;
                else
                    obj.achAlign = false;
                end
            elseif (deptA.centroidY < deptB.centroidY) && (deptB.sizeU + deptA.sizeD) == abs(deptA.centroidY - deptB.centroidY) && (deptA.centroidX - deptA.sizeL <= deptB.centroidX + deptB.sizeR) && (deptA.centroidX + deptA.sizeR >= deptB.centroidX - deptB.sizeL)
                %down
                obj.achAdj = true;
                if deptA.centroidX + deptA.sizeR == deptB.centroidX + deptB.sizeR && deptA.centroidX - deptA.sizeL == deptB.centroidX - deptB.sizeL
                    obj.achAlign = true;
                else
                    obj.achAlign = false;
                end
            elseif (deptA.centroidX > deptB.centroidX) && (deptB.sizeR + deptA.sizeL) == abs(deptA.centroidX - deptB.centroidX) && (deptA.centroidY - deptA.sizeU <= deptB.centroidY + deptB.sizeD) && (deptA.centroidY + deptA.sizeD >= deptB.centroidY - deptB.sizeU)
                %left
                obj.achAdj = true;
                if deptA.centroidY + deptA.sizeD == deptB.centroidY + deptB.sizeD && deptA.centroidY - deptA.sizeU == deptB.centroidY - deptB.sizeU
                    obj.achAlign = true;
                else
                    obj.achAlign = false;
                end
            elseif distX_Y == (diagonalA + diagonalB)
                obj.achAdj = true;
                obj.achAlign = false;
            else
                obj.achAdj = false;
                obj.achAlign = false;
            end
        end
        function bool = checkDept(obj, dept)
            if obj.deptA == dept || obj.deptB == dept
                bool = true;
            else
                bool = false;
            end
        end

    end
end