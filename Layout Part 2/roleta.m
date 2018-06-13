function [result] = roleta(solution)
%para testes
  % if ( (sum(solution) > 100) || (sum(solution)<100) )
  %     disp('O total da soma das entradas deve ser 100')
  %     erro = 1;
  %     result = 0;
  % end

%adaptando de decimal para porcentagem
for i=1:length(solution)
  solution(i) = solution(i) * 100;
end

  %intervalo de cada depto
  [lin nsolution] = size(solution);
  min = zeros(lin,nsolution);
  max = zeros(lin,nsolution);

  %frequencia dos resultados em cada depto
  y = zeros(lin,nsolution);

  for i=1:nsolution
      if i == 1
          min(i) = 1;
          max(i) = solution(i);
      else
          min(i) = max(i-1) +1;
          max(i) = min(i)+solution(i) -1;
      end
  end

  %retira a parte decimal
  min = ceil(min);
  max = ceil(max);

  rodada = ceil(rand*100);
  %procura no vetor de minimos
  for k=1:nsolution
      if ( (rodada >= min(k)) && (rodada <= max(k)))
          y(k) = y(k)+1;
      end
  end
  %verifica o departamento escolhido
  for i = 1:length(y)
    if y(i) == 1
      result = i;
    end
  end

end
