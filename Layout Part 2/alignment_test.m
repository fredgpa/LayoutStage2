function [ test ] = alignment_test( problem, individual )
  test = true;
  individual
  if not(isempty(problem.constraint))
    for k=1:length(problem.constraint)
      pos1 = [];
      pos2 = [];
      for i=1:length(individual)
        if individual(i) == problem.constraint(k, 1)
          pos1 = i;
        elseif individual(i) == problem.constraint(k, 2)
          pos2 = i;
        end
      end
      if isempty(pos1) || isempty(pos2)
        test = false;
        return;
      end
      if (problem.constraint(k, 3) == 1)
        if (abs(pos1 - pos2) ~= 1) && (abs(pos1 - pos2) ~= problem.width)
          test = false;
        end
      else
        if (abs(pos1 - pos2) ~= 1) && (abs(pos1 - pos2) ~= problem.width) && (abs(pos1 - pos2) ~= (problem.width+1)) && (abs(pos1 - pos2) ~= (problem.width-1))
          test = false;
        end
      end
    end
  end

end
