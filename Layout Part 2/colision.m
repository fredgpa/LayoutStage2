function [hit] = colision(department, direction, sol_final)
  hit = [];
  if (direction == 'right')
    if (department.X + department.E) < 46
      for i=(department.Y - department.N):(department.Y + department.S)
        if (sol_final(i, (department.X + department.E + 1)) ~= 0)
          if ~(ismember(sol_final(i, (department.X + department.E + 1)), hit))
            hit = [hit sol_final(i, (department.X + department.E + 1))];
          end
        end
      end
    end
  elseif direction ==  'up'
    if (department.Y - department.N) > 1
      for i=(department.X - department.W):(department.X + department.E)
        if (sol_final((department.Y - department.N - 1), i) ~= 0)
          if ~(ismember(sol_final((department.Y - department.N - 1), i), hit))
            hit = [hit sol_final((department.Y - department.N - 1), i)];
          end
        end
      end
    end
  elseif direction ==  'left'
    if (department.X - department.W) > 1
      for i=(department.Y - department.N):(department.Y + department.S)
        if (sol_final(i, (department.X - department.W - 1)) ~= 0)
          if ~(ismember(sol_final(i, (department.X - department.W - 1)), hit))
            hit = [hit sol_final(i, (department.X - department.W - 1))];
          end
        end
      end
    end
  elseif direction ==  'down'
    if (department.Y + department.S) < 22
      for i=(department.X - department.W):(department.X + department.E)
        if (sol_final((department.Y + department.S + 1), i) ~= 0)
          if ~(ismember(sol_final((department.Y + department.S + 1), i), hit))
            hit = [hit sol_final((department.Y + department.S + 1), i)];
          end
        end
      end
    end
  end

end
