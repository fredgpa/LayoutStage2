function [ materials ] = matriz_materiais()

  n_var = input('Number of departments: ');
  materials = zeros(n_var);
  for i = 1:n_var
    for j = 1:n_var
      if i ~= j
        x = input(['Expected material flow from departments ' num2str(i) ' to ' num2str(j) ': ']);
        if not(isempty(x))
          materials(i, j) = x;
        end
      end
    end
  end
end
