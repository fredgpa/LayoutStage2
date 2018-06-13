function [ costs ] = matriz_custos()

  n_var = input('Number of departments: ');
  costs = zeros(n_var);
  for i = 1:n_var
    for j = 1:n_var
      if i ~= j
        x = input(['Transportation cost between departments ' num2str(i) ' and ' num2str(j) ': ']);
        if not(isempty(x))
          costs(i, j) = x;
        end
      end
    end
  end
end
