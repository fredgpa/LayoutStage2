function [ solution ] = estaleiro_generate_random( problem, ~ )
  solution = zeros(1, problem.n_var);
  array = randperm(problem.n_var, problem.n_var);
  it = 0;
  if not(isempty(problem.fixedPos))
    for k = 1:length(problem.fixedPos)
      array(array == problem.fixedPos(k).dept) = [];
      position = ((problem.fixedPos(k).i - 1) * problem.width) + problem.fixedPos(k).j;
      solution(position) = problem.fixedPos(k).dept;
    end
  end
  if not(isempty(problem.constraint.Edges))
    for k=1:length(problem.constraint.Edges.EndNodes)
      array(array == problem.constraint.Edges.EndNodes(k, 1)) = [];
      array(array == problem.constraint.Edges.EndNodes(k, 2)) = [];
    end
    for i=1:problem.n_var
      positions(i) = i;
    end
    repeat = true;
    temp_solution = zeros(1, problem.n_var);
    solution_backup = solution;
    while repeat
      if it == 30
        solution = solution_backup;
        it = 0;
      end
      it = it + 1
      repeat = false;
      for k=1:length(problem.constraint.Edges.EndNodes)
        temp_positions = [];
        ok = true;
        new1 = true;
        new2 = true;
        for i=1:length(solution)
          if solution(i) == problem.constraint.Edges.EndNodes(k, 1)
            pos = i;
            new1 = false;
          end
        end
        for i=1:length(solution)
          if (solution(i) == problem.constraint.Edges.EndNodes(k, 2))
            new2 = false;
            if new1
              pos = i;
            end
          end
        end
        if new1 && new2
          [ok, temp_solution, pos] =constraint_calc(problem.constraint.Edges.EndNodes(k, 1), positions, solution);
          temp_positions = [];
            if mod(pos-1, problem.width) ~= 0
              temp_positions = [temp_positions [pos-1]];
            end
            if pos > problem.width
              temp_positions = [temp_positions [pos-problem.width]];
            end
            if mod(pos, problem.width) ~= 0
              temp_positions = [temp_positions [pos+1]];
            end
            if pos <= (length(solution) - problem.width)
              temp_positions = [temp_positions [pos+problem.width]];
            end
          [ok, temp_solution, ~] =constraint_calc(problem.constraint.Edges.EndNodes(k, 2), temp_positions, temp_solution);
          if not(ok)
            temp_solution(pos) = 0;
            repeat = true;
          end
        elseif (not(new1)) && (not(new2))
          pos = [];
          for i=1:length(solution)
            if solution(i) == problem.constraint.Edges.EndNodes(k, 1)
              pos(1) = i;
            elseif solution(i) == problem.constraint.Edges.EndNodes(k, 2)
              pos(2) = i;
            end
          end
          fixed = randi(2);
          if fixed == 1
            moving = 2;
          else
            moving = 1;
          end
            if (pos(moving) ~= (pos(fixed)+1)) && (pos(moving) ~= (pos(fixed)-1)) && (pos(moving) ~= (pos(fixed)-problem.width)) && (pos(moving) ~= (pos(fixed)+problem.width))
              repeat = true;
              temp_positions = [];
              if mod(pos(fixed)-1, problem.width) ~= 0
                temp_positions = [temp_positions [pos(fixed)-1]];
              end
              if pos(fixed) > problem.width
                temp_positions = [temp_positions [pos(fixed)-problem.width]];
              end
              if mod(pos(fixed), problem.width) ~= 0
                temp_positions = [temp_positions [pos(fixed)+1]];
              end
              if pos(fixed) <= (length(solution) - problem.width)
                temp_positions = [temp_positions [pos(fixed)+problem.width]];
              end
              solution(pos(moving)) = 0;
              if fixed == 1
                [ok, temp_solution, ~] =constraint_calc(problem.constraint.Edges.EndNodes(k, 2), temp_positions, solution);
              else
                [ok, temp_solution, ~] =constraint_calc(problem.constraint.Edges.EndNodes(k, 1), temp_positions, solution);
              end
            end
          if not(ok)
            pos(fixed)
            temp_solution(pos(fixed)) = 0;
            repeat = true;
          end
        else
          temp_positions = [];
            if mod(pos-1, problem.width) ~= 0
              temp_positions = [temp_positions [pos-1]];
            end
            if pos > problem.width
              temp_positions = [temp_positions [pos-problem.width]];
            end
            if mod(pos, problem.width) ~= 0
              temp_positions = [temp_positions [pos+1]];
            end
            if pos <= (length(solution) - problem.width)
              temp_positions = [temp_positions [pos+problem.width]];
            end
          if new1 && not(new2)
            [ok, temp_solution, ~] =constraint_calc(problem.constraint.Edges.EndNodes(k, 1), temp_positions, solution);
          elseif not(new1) && new2
            [ok, temp_solution, ~] =constraint_calc(problem.constraint.Edges.EndNodes(k, 2), temp_positions, solution);
          end
          if not(ok)
            temp_solution(pos) = 0;
            repeat = true;
          end
        end
        solution = temp_solution;
      end
      if alignment_test(problem, solution) == false
        repeat = true;
      end
    end
  end
  for i = 1:length(solution)
    if solution(i) == 0
      solution(i) = array(1);
      array(1) = [];
    end
  end
end
