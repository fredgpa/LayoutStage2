function [] = crossover_test(parent1, parent2)
  n_parents = length(parent1);
  child = zeros(1,length(parent1));
  pos_parent1 = randi(n_parents);
  aux = []; first = [];
  end_cycle = false;
  first = parent1(pos_parent1);
    while not(end_cycle)
      aux = 1
      child
      child(pos_parent1) = parent1(pos_parent1);
      if parent1(pos_parent1) == first
        aux = 2
        break;
      end
      for i=1:length(parent1)
        aux = 3
        if parent1(i) == parent2(pos_parent1);
          pos_parent1 = i;
        end
      end
    end
    for i=1:length(child)
      aux = 4
      parent2(parent2 == child(i)) = [];
    end

    for i=1:length(child)
      aux = 5
      if child(i) == 0
        child(i) = parent2(1);
        parent2(1) = [];
      end
    end

  child

  end
