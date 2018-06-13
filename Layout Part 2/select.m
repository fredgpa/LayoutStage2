function F = select(p,X)

  x = cumsum([0 p(:).'/sum(p(:))]);

  x(end) = 1e3*eps + x(end);

  [a a] = histc(rand,x);

  n = X(a);

  for i = 1:length(X)
    if X(i) == n
      F = i;
    end
  end

end
