classdef (ClassAttributes) Department
    properties (PropertyAttributes)
        n = [];
        centroid_X = [];
        centroid_Y = [];
        size_U = 0;
        size_D = 0;
        size_R = 0;
        size_L = 0;
        req_Area = [];
        req_Aspect = [];
        fixed_Pos = [];
        fixed_Size = [];
    end
    methods (MethodAttributes)
        function result = calcArea(obj)
            result = (obj.size_D + obj.size_U + 1) * (obj.size_L + obj.size_R + 1);
        end
        function obj = grow(obj, dir)
            if dir == "up"
                obj.size_U = obj.size_U + 1;
            elseif dir == "right"
                obj.size_R = obj.size_R + 1;
            elseif dir == "down"
                obj.size_D = obj.size_D + 1;
            else
                obj.size_L = obj.size_L + 1;
            end
        end
        function obj = shrink(obj, dir)
            if dir == "up"
                obj.size_U = obj.size_U - 1;
            elseif dir == "right"
                obj.size_R = obj.size_R - 1;
            elseif dir == "down"
                obj.size_D = obj.size_D - 1;
            else
                obj.size_L = obj.size_L - 1;
            end
        end
        function obj = move(obj, dir)
            if dir == "up"
                obj.centroid_Y = obj.centroid_Y - 1;
            elseif dir == "right"
                obj.centroid_X = obj.centroid_X + 1;
            elseif dir == "down"
                obj.centroid_Y = obj.centroid_Y + 1;
            else
                obj.centroid_X = obj.centroid_X - 1;
            end
        end        
    end
end