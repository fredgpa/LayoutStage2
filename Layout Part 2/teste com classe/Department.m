classdef (ClassAttributes) Department
    properties (PropertyAttributes)
        n = [];
        centroidX = [];
        centroidY = [];
        sizeU = 0;
        sizeD = 0;
        sizeR = 0;
        sizeL = 0;
        reqArea = [];
        reqAspect = [];
        fixedPos = [];
        fixedSize = [];
        directions = [];
    end
    methods (MethodAttributes)
        function obj = updateDir(obj)
            if (obj.sizeL + obj.sizeR + 1) < (obj.sizeU + obj.sizeD + 1)
                directions = ["up" "down" "right" "left"];
            else
                directions = ["left" "right" "up" "down"];
            end
        end
        function result = calcArea(obj)
            result = (obj.sizeD + obj.sizeU + 1) * (obj.sizeL + obj.sizeR + 1);
        end
        function obj = grow(obj, dir)
            if dir == "up"
                obj.sizeU = obj.sizeU + 1;
            elseif dir == "right"
                obj.sizeR = obj.sizeR + 1;
            elseif dir == "down"
                obj.sizeD = obj.sizeD + 1;
            else
                obj.sizeL = obj.sizeL + 1;
            end
        end
        function obj = shrink(obj, dir)
            if dir == "up"
                obj.sizeU = obj.sizeU - 1;
            elseif dir == "right"
                obj.sizeR = obj.sizeR - 1;
            elseif dir == "down"
                obj.sizeD = obj.sizeD - 1;
            else
                obj.sizeL = obj.sizeL - 1;
            end
        end
        function obj = move(obj, dir)
            if dir == "up"
                obj.centroidY = obj.centroidY - 1;
            elseif dir == "right"
                obj.centroidX = obj.centroidX + 1;
            elseif dir == "down"
                obj.centroidY = obj.centroidY + 1;
            else
                obj.centroidX = obj.centroidX - 1;
            end
        end        
    end
end