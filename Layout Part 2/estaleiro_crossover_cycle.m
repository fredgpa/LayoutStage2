function child = estaleiro_crossover_cycle(parents,problem,~,population)
  n_parents = length(parents);
  randparents = randperm(n_parents);
  parent1 = population.ind{parents(randparents(1))};
  parent2 = population.ind{parents(randparents(2))};
  child = problem;
  pos_parent1 = randi(length(problem.solution));
  aux = []; first = [];
  first = parent1.solution(pos_parent1);
    while true
      child.solution(pos_parent1) = parent1.solution(pos_parent1);
      child.departments(pos_parent1) = parent1.departments(pos_parent1);
      child.req_area(pos_parent1) = parent1.req_area(pos_parent1);
      if parent1.solution(pos_parent1) == first
        break;
      end
      for i=1:length(parent1.solution)
        if parent1.solution(i) == parent2.solution(pos_parent1);
          pos_parent1 = i;
        end
      end
    end
    for i=1:length(child.solution)
      parent2.solution(parent2.solution == child.solution(i)) = [];
    end
    for i=1:length(child.solution)
      if child.solution(i) == 0
        child.solution(i) = parent2.solution(1);
        child.req_area(i) = parent2.req_area(1);
        child.departments(i) = parent2.departments(1);
        parent2.solution(1) = [];
        parent2.departments(1) = [];
        parent2.solution(1) = [];
      end
    end
end
