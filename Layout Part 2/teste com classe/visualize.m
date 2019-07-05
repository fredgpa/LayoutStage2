function [ visual ] = visualize(departments)
    visual = zeros(22, 46);
    for i=1:length(departments)   
      for j=(departments(i).centroidX - departments(i).sizeL):(departments(i).centroidX + departments(i).sizeR)
        for k=(departments(i).centroidY - departments(i).sizeU):(departments(i).centroidY + departments(i).sizeD)
            visual(k, j) = departments(i).n;
        end
      end
    end

end

