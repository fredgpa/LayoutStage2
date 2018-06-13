function [ fx, solution, problem ] = estaleiro_evaluate( solution, problem, ~)

  solution.solution
  for i=1:length(solution.solution)
    ach_area(i) = (solution.departments(i).E + solution.departments(i).W + 1)*(solution.departments(i).S + solution.departments(i).N + 1);
    if (solution.departments(i).E + solution.departments(i).W) > (solution.departments(i).N + solution.departments(i).S)
      ach_aspect(solution.solution(i)) = (solution.departments(i).E + solution.departments(i).W + 1) / (solution.departments(i).N + solution.departments(i).S + 1);
    else
      ach_aspect(solution.solution(i)) = (solution.departments(i).N + solution.departments(i).S + 1) / (solution.departments(i).E + solution.departments(i).W + 1);
    end
  end

  ach_align = zeros(length(solution.solution));
    ach_adj = zeros(length(solution.solution));
    for i=1:length(solution.departments)
      for j=1:length(solution.departments)
        if i ~= j
          if (solution.departments(i).Y - solution.departments(i).N) == (solution.departments(j).Y + solution.departments(j).S + 1) || (solution.departments(i).Y + solution.departments(i).S) == (solution.departments(j).Y - solution.departments(j).N - 1)
            ach_adj(problem.solution(i), problem.solution(j)) = 1;
            if ((solution.departments(i).X == (solution.departments(j).X)) && (solution.departments(i).W == (solution.departments(j).W)) && (solution.departments(i).E == (solution.departments(j).E)))
              ach_align(solution.solution(i), solution.solution(j)) = 1;
            end
          end
          if (solution.departments(i).X + solution.departments(i).E) == (solution.departments(j).X - solution.departments(j).W - 1) || (solution.departments(i).X - solution.departments(i).W) == (solution.departments(j).X + solution.departments(j).E + 1)
            ach_adj(solution.solution(i), solution.solution(j)) = 1;
            if ((solution.departments(i).Y == (solution.departments(j).Y)) && (solution.departments(i).N == (solution.departments(j).N)) && (solution.departments(i).S == (solution.departments(j).S)))
              ach_align(solution.solution(i), solution.solution(j)) = 1;
            end
          end
        end
      end
    end

  value1 = 0;
  value2 = 0;
  value3 = 0;
  distance = zeros(length(solution.departments));
  for i=1:length(solution.departments)
    for j=1:length(solution.departments)
      distance(i, j) = abs(solution.departments(i).X - solution.departments(j).X) + abs(solution.departments(i).Y - solution.departments(j).Y);
      value1 = value1 + (problem.weight_factor(1) * solution.materials(solution.solution(i), solution.solution(j)) * solution.costs(solution.solution(i), solution.solution(j)) * distance(i, j));
    end
    value2 = value2 + (problem.weight_factor(2) * (abs(solution.req_area(i) - ach_area(i)) / solution.req_area(i)));
    value3 = value3 + (problem.weight_factor(3) * (abs(solution.req_aspect(solution.solution(i)) - ach_aspect(solution.solution(i)))));
  end
  value4 = 0;
  value5 = 0;
  for i=1:(length(solution.departments) - 1)
    for j=(i + 1):length(solution.departments)
      value4 = value4 + (problem.weight_factor(4) * solution.req_adj(solution.solution(i), solution.solution(j))*(1 - ach_adj(solution.solution(i), solution.solution(j))));
      value5 = value5 + (problem.weight_factor(5) * solution.req_align(solution.solution(i), solution.solution(j))*(1 - ach_align(solution.solution(i), solution.solution(j))));
    end
  end
  fx = value1 + value2 + value3 + value4 + value5;
end
