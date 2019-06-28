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
    end
    methods (MethodAttributes)
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