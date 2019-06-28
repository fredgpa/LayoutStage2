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
            distX_Y = sqrt((deptA.centroid_X - deptB.centroid_X)^2 + (deptA.centroid_Y - deptB.centroid_Y)^2);
            diagonalA = sqrt((deptA.size_R + 0.5)^2 + (deptA.size_D + 0.5)^2);
            diagonalB = sqrt((deptB.size_R + 0.5)^2 + (deptB.size_D + 0.5)^2);
            
            if deptA.size_R >= deptA.size_D
                biggest_side_A = deptA.size_R;
            else
                biggest_side_A = deptA.size_D;
            end
            
            if deptB.size_R >= deptB.size_D
                biggest_side_B = deptB.size_R;
            else
                biggest_side_B = deptB.size_D;
            end

            if distX_Y <= (diagonalA + diagonalB)
                obj.achAdj = true;
                if (distX_Y == ((deptA.size_R + deptA.size_L)/2) + ((deptB.size_R + deptB.size_L)/2) + 1) && (deptA.size_U + deptA.size_D == deptB.size_U + deptB.size_D)
                    obj.achAlign = true;
                elseif (distX_Y == ((deptA.size_D + deptA.size_U)/2) + ((deptB.size_D + deptB.size_U)/2) + 1) && (deptA.size_L + deptA.size_R == deptB.size_L + deptB.size_R)
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
            if obj.deptA == dept || obj.deptB = dept
                bool = true;
            else
                bool = false;
            end
        end

    end
end