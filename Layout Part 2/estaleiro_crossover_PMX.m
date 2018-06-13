function child = estaleiro_crossover_PMX(parents,problem,~,population)
  n_parents = length(parents);
  randparents = randperm(n_parents);
  parent1 = population.ind{parents(randparents(1))};
  parent2 = population.ind{parents(randparents(2))};
  child = problem;
  child.solution = zeros(1, length(problem.solution));

  len = randi(length(problem.solution)-1);
  start = randi(length(problem.solution) - len);
    child.solution(start:(start + len)) = parent1.solution(start:(start + len));
  for i = start:(start + len)
    if ~ismember(parent2.solution(i), child.solution)
      value = parent1.solution(i);
      ok = false;
      while ~ok
        for j = 1:length(parent2.solution)
          if parent2.solution(j) == value
            if j >= start && j <= start + len
              value = parent1.solution(j);
            else
              child.solution(j) = parent2.solution(i);
              ok = true;
            end
          end
        end
      end
    end
  end
  for i = 1:length(parent2.solution)
    for j = 1:length(child.solution)
      if ~ismember(parent2.solution(i), child.solution) && child.solution(j) == 0
        child.solution(j) = parent2.solution(i);
      end
    end
  end
end
