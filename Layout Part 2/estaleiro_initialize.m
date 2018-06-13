function [ problem ] = estaleiro_initialize( costs, materials, req_area, req_aspect )

  problem.name = 'estaleiro';
  problem.minimization = true;

  problem.generation_method = 'random';
  problem.mutation_method = 'bitflop';
  problem.crossover_method1 = 'cycle';
  problem.crossover_method2 = 'PMX';

  %%Definindo a instancia do problema
  problem.n_var = input('Number of departments: ');

  problem.solution = [];
  for i = 1:problem.n_var;
    problem.solution(i) = input(['Departamento na posição ' int2str(i) ':']);
  end

  problem.costs = costs;
  sz = size(problem.costs);
  if sz(1) ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Costs','modal')
    return;
  end

  problem.req_area = req_area;
  sz = size(problem.costs);
  if sz(1) ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Req Area','modal')
    return;
  end

  problem.req_aspect = req_aspect;
  sz = size(problem.costs);
  if sz(1) ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Req Aspect','modal')
    return;
  end

  problem.materials = materials;
  sz = size(problem.materials);
  if sz(1) ~= problem.n_var
    warndlg({'Incompatible dimmensions'},'Error - Materials','modal')
    return;
  end

  problem.dimY = input('Matrix Height: ');
  problem.dimX = input('Matrix Width: ');


  problem.req_adj = [];
  problem.req_align = [];
  problem.constraint = [];
  ans = input('Any constraints between departments? (y/n)', 's');
  ans = upper(ans);
  if ans == 'Y'
      problem.req_adj = zeros(problem.n_var);
      problem.req_align = zeros(problem.n_var);
    n = input('How many departments have constraints? ');
    for i = 1:n
      dept1 = input('First department number: ');
      dept2 = input('Second department number: ');
      problem.req_adj(dept1, dept2) = 1;
      problem.req_adj(dept2, dept1) = 1;
      problem.constraint(i, 1) = dept1;
      problem.constraint(i, 2) = dept2;
      ans = input('Must the departments be aligned? (y/n)', 's');
      if upper(ans) == 'Y'
        problem.req_align(dept1, dept2) = 1;
        problem.req_align(dept2, dept1) = 1;
        problem.constraint(i, 3) = true;
      else
        problem.constraint(i, 3) = false;
      end
    end
  end

  n_weight = input('How many weight factors are there on the problem?');
  for i = 1:n_weight
    problem.weight_factor(i) = input(['Weight ' int2str(i) ':']);
  end

  load('departments.mat');
  problem.departments = departments;
end
