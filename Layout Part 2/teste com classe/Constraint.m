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

            if distX_Y <= (diagonalA + diagonalB)
                obj.achAdj = true;
                if (distX_Y == ((deptA.sizeR + deptA.sizeL)/2) + ((deptB.sizeR + deptB.sizeL)/2)) && (deptA.sizeU + deptA.sizeD == deptB.sizeU + deptB.sizeD)
                    obj.achAlign = true;
                elseif (distX_Y == ((deptA.sizeD + deptA.sizeU)/2) + ((deptB.sizeD + deptB.sizeU)/2)) && (deptA.sizeL + deptA.sizeR == deptB.sizeL + deptB.sizeR)
                    obj.achAlign = true;
                else
                    obj.achAlign = false;
                end
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