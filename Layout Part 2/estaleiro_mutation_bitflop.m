function x = estaleiro_mutation_bitflop(x, ~,~,~)
  pos = [];
  pos(1) = randi(length(x));
  pos(2) = randi(length(x));

  aux = x.solution(pos(1));
  x.solution(pos(1)) = x.solution(pos(2));
  x.solution(pos(2)) = aux;

  aux = x.req_area(pos(1));
  x.req_area(pos(1)) = x.req_area(pos(2));
  x.req_area(pos(2)) = aux;

  aux = x.departments(pos(1));
  x.departments(pos(1)) = x.departments(pos(2));
  x.departments(pos(2)) = aux;
end
