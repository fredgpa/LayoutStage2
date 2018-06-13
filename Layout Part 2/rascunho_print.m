sol_final = zeros(p.best.dimY, p.best.dimX);
    for i=1:length(p.best.departments)
      %length(departments)
      for j=(p.best.departments(i).X - p.best.departments(i).W):(p.best.departments(i).X + p.best.departments(i).E)
        for k=(p.best.departments(i).Y - p.best.departments(i).N):(p.best.departments(i).Y + p.best.departments(i).S)
            sol_final(k, j) = p.best.solution(i);
        end
      end
    end