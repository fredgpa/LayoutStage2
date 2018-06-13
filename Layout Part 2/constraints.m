  for i=1:problem.n_var
    positions(i) = i;
  end
  temp_solution = zeros(1, problem.n_var);
  for k=1:length(problem.constraint.Edges.EndNodes)
    ok = true;
    new = true;
    for i=1:length(solution)
      if solution(i) == problem.constraint.Edges.EndNodes(k, 1)
        pos = i;
        new = false;
      end
    end
    if new
      [ok, temp_solution, pos] =constraint_calc(problem.constraint.Edges.EndNodes(k, 1), positions, solution);
      if problem.constraint.Edges.align == 1
        temp_positions = [(pos+1) (pos-1) (pos-problem.width) (pos+problem.width)];
      else
        temp_positions = [(pos+1) (pos-1) (pos-problem.width) (pos+problem.width) (pos+problem.width-1) (pos+problem.width+1) (pos-problem.width-1) (pos-problem.width+1)];
      end
      [ok, temp_solution, pos] =constraint_calc(problem.constraint.Edges.EndNodes(k, 2), temp_positions, temp_solution);
    else
      if problem.constraint.Edges.align == 1
        temp_positions = [(pos+1) (pos-1) (pos-problem.width) (pos+problem.width)];
      else
        temp_positions = [(pos+1) (pos-1) (pos-problem.width) (pos+problem.width) (pos+problem.width-1) (pos+problem.width+1) (pos-problem.width-1) (pos-problem.width+1)];
      end
      [ok, temp_solution, pos] =constraint_calc(problem.constraint.Edges.EndNodes(k, 2), temp_positions, solution);
    end
    if ok
      solution = temp_solution;
    end
  end
