function [ok, solution, positions] = constraint_calc(node, positions, solution)
  repeat = true;

  while repeat
    if not(isempty(positions))
      x = randi(length(positions));
      pos = positions(x);
      positions(x) = [];
      if solution(pos) == 0
        solution(pos) = node;
        ok = true;
        repeat = false;
      end
    else
      ok = false;
      repeat = false;
    end
  end
end
