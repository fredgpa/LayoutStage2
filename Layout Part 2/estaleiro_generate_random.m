function [ problem ] = estaleiro_generate_random( problem, ~ )
  tic; %inicia contagem do relogio

  finish = false; %variavel para o fim do loop
  area_difference = zeros(1, length(problem.solution));
  sol_final = zeros(problem.dimY, problem.dimX);
  final_recovery = 0;
  teste = 0;
  iteracoes = 0;
  freq = 0;



  while not(finish)
      alfa = 0; beta = 0;
    teste = teste + 1;
    for i=1:length(problem.solution)
      ach_area(i) = (problem.departments(i).E + problem.departments(i).W + 1)*(problem.departments(i).S + problem.departments(i).N + 1);
      if (problem.departments(i).E + problem.departments(i).W) > (problem.departments(i).N + problem.departments(i).S)
        ach_aspect(problem.solution(i)) = (problem.departments(i).E + problem.departments(i).W + 1) / (problem.departments(i).N + problem.departments(i).S + 1);
      else
        ach_aspect(problem.solution(i)) = (problem.departments(i).N + problem.departments(i).S + 1) / (problem.departments(i).E + problem.departments(i).W + 1);
      end
    end
%{
    000000                                  000000111111
    0000001111111                           000000111111
    0000001111111  -> ach_adj = 1           000000111111    -> ach_align = 1
    0000001111111                           000000111111
          1111111
%}
    ach_align = zeros(length(problem.solution));
    ach_adj = zeros(length(problem.solution));
    for i=1:length(problem.departments)
      for j=1:length(problem.departments)
        if i ~= j
          if (problem.departments(i).Y - problem.departments(i).N) == (problem.departments(j).Y + problem.departments(j).S + 1) || (problem.departments(i).Y + problem.departments(i).S) == (problem.departments(j).Y - problem.departments(j).N - 1)
            ach_adj(problem.solution(i), problem.solution(j)) = 1;
            if ((problem.departments(i).X == (problem.departments(j).X)) && (problem.departments(i).W == (problem.departments(j).W)) && (problem.departments(i).E == (problem.departments(j).E)))
              ach_align(problem.solution(i), problem.solution(j)) = 1;
            end
          end
          if (problem.departments(i).X + problem.departments(i).E) == (problem.departments(j).X - problem.departments(j).W - 1) || (problem.departments(i).X - problem.departments(i).W) == (problem.departments(j).X + problem.departments(j).E + 1)
            ach_adj(problem.solution(i), problem.solution(j)) = 1;
            if ((problem.departments(i).Y == (problem.departments(j).Y)) && (problem.departments(i).N == (problem.departments(j).N)) && (problem.departments(i).S == (problem.departments(j).S)))
              ach_align(problem.solution(i), problem.solution(j)) = 1;
            end
          end
        end
      end
    end

    %calcula a diferenÃ§a entre a Ã¡rea obtida no momento da iteraÃ§Ã£o com a Ã¡rea Ã³tima
    total_area_dif = 0;
    for i = 1:length(problem.solution)
      area_difference(i) = problem.req_area(i) - ach_area(i);
      total_area_dif = total_area_dif + area_difference(i);
    end

    %calcula as probabilidades de cada departamento na roleta
    for i = 1:length(problem.solution)
      if area_difference(i) == 0
        prob(i) = 0;
      else
        prob(i) = abs(area_difference(i))/abs(total_area_dif);
      end
    end
    %prob
    %algoritmo de roleta seleciona um departamento
    if sum(prob) ~= 0
        dept_number = roleta(prob);
    end

    while problem.departments(dept_number).fixed
      dept_number = roleta(prob);
    end

    dept_number
    prob
    problem.solution(dept_number)

    if sum(prob) ~= 0
        %tendo o departamento selecionado, decide-se entre cresce-lo ou diminui-lo
        target =[];
        if ~isempty(problem.constraint)
            target = attract(dept_number, problem.constraint, problem.departments, problem.solution);
        end
          if (problem.departments(i).N + problem.departments(i).S) > (problem.departments(i).E + problem.departments(i).W)
            directions = ["up", "down", "right", "left"];
            if ~isempty(target)
                if ismember("up", target)
                    alfa = alfa + 10;
                end
                if ismember("down", target)
                    alfa = alfa - 10;
                end
                if ismember("right", target)
                    beta = beta + 10;
                end
                if ismember("left", target)
                    beta = beta - 10;
                end
            end
          else
            directions = ["left", "right", "up", "down"];
            if ~isempty(target)
                if ismember("left", target)
                    alfa = alfa + 10;
                end
                if ismember("right", target)
                    alfa = alfa - 10;
                end
                if ismember("up", target)
                    beta = beta + 10;
                end
                if ismember("down", target)
                    beta = beta - 10;
                end
            end
          end
        if area_difference(dept_number) > 0
          %cresce
          if problem.req_aspect(problem.solution(dept_number)) <= ach_aspect(problem.solution(dept_number))/2
            direction_prob(1) = (10 + alfa) / 100;
            direction_prob(2) = (10 - alfa) / 100;
            direction_prob(3) = (40 + beta) / 100;
            direction_prob(4) = (40 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) < ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (20 + alfa) / 100;
            direction_prob(2) = (20 - alfa) / 100;
            direction_prob(3) = (30 + beta) / 100;
            direction_prob(4) = (30 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) >= 2*ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (40 + alfa) / 100;
            direction_prob(2) = (40 - alfa) / 100;
            direction_prob(3) = (10 + beta) / 100;
            direction_prob(4) = (10 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) > ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (30 + alfa) / 100;
            direction_prob(2) = (30 - alfa) / 100;
            direction_prob(3) = (20 + beta) / 100;
            direction_prob(4) = (20 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) == ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (25 + alfa) / 100;
            direction_prob(2) = (25 - alfa) / 100;
            direction_prob(3) = (25 + beta) / 100;
            direction_prob(4) = (25 - beta) / 100;
          end

          %alfa_array = [alfa_array alfa];
          %beta_array = [beta_array beta];

          %apÃ³s calculadas as probabilidades de cada direÃ§Ã£o, utiliza-se o algoritmo da roleta para selecionar uma
          direction_n = roleta(direction_prob);
          directions(direction_n)
          %directions(direction_n)
          %baseando-se na direÃ§Ã£o escolhida, ocorre o teste para verificar se seu aumento se encontra obstruÃ­do por outro departamento.
          %caso se encontre, Ã© feito o "Push"
          n = 1;
          hit = colision(problem.departments(dept_number), directions(direction_n), sol_final)
          hit_pos = [];
          %a partir do array hit, encontra a posiÃ§Ã£o dos arrays na soluÃ§Ã£o
          for i=1:length(hit)
            for j=1:length(problem.solution)
              if problem.solution(j) == hit(i)
                hit_pos(i) = j;
              end
            end
          end
          if ~isempty(hit_pos)
            %push
              cancel = false;
              if directions(direction_n) == 'left'
                %checa se todos os departamentos com os quais haveria obstruÃ§Ã£o podem ser diminuidos
                for i=1:length(hit_pos)
                  if problem.departments(hit_pos(i)).fixed
                    cancel = true;
                  elseif (problem.departments(hit_pos(i)).E == 0) && ((problem.departments(hit_pos(i)).X == 1) || (problem.departments(hit_pos(i)).W == 0))
                    cancel = true;
                  end
                end
                if ~(cancel)
                  problem.departments(dept_number).W = problem.departments(dept_number).W + 1;
                  for i=1:length(hit_pos)
                    if problem.departments(hit_pos(i)).E > 0
                      problem.departments(hit_pos(i)).E = problem.departments(hit_pos(i)).E - 1;
                    elseif ~problem.departments(dept_number).fixedCentroid
                      problem.departments(hit_pos(i)).X = problem.departments(hit_pos(i)).X - 1;
                      problem.departments(hit_pos(i)).W = problem.departments(hit_pos(i)).W - 1;
                    end
                  end
                end
              elseif directions(direction_n) == 'up'
                %checa se todos os departamentos com os quais haveria obstruÃ§Ã£o podem ser diminuidos
                for i=1:length(hit_pos)
                  if problem.departments(hit_pos(i)).fixed
                    cancel = true;
                  elseif (problem.departments(hit_pos(i)).S == 0) && ((problem.departments(hit_pos(i)).Y == 1) || (problem.departments(hit_pos(i)).N == 0))
                    cancel = true;
                  end
                end
                if not(cancel)
                  problem.departments(dept_number).N = problem.departments(dept_number).N + 1;
                  for i=1:length(hit_pos)
                    if problem.departments(hit_pos(i)).S > 0
                      problem.departments(hit_pos(i)).S = problem.departments(hit_pos(i)).S - 1;
                    elseif ~problem.departments(dept_number).fixedCentroid
                      problem.departments(hit_pos(i)).Y = problem.departments(hit_pos(i)).Y - 1;
                      problem.departments(hit_pos(i)).N = problem.departments(hit_pos(i)).N - 1;
                    end
                  end
                end
              elseif directions(direction_n) == 'right'
                %checa se todos os departamentos com os quais haveria obstruÃ§Ã£o podem ser diminuidos
                for i=1:length(hit_pos)
                  if problem.departments(hit_pos(i)).fixed
                    cancel = true;
                  elseif (problem.departments(hit_pos(i)).W == 0) && ((problem.departments(hit_pos(i)).X == 46) || (problem.departments(hit_pos(i)).E == 0))
                    cancel = true;
                  end
                end
                if not(cancel)
                  problem.departments(dept_number).E = problem.departments(dept_number).E + 1;
                  for i=1:length(hit_pos)
                    if problem.departments(hit_pos(i)).W > 0
                      problem.departments(hit_pos(i)).W = problem.departments(hit_pos(i)).W - 1;
                    elseif ~problem.departments(dept_number).fixedCentroid
                      problem.departments(hit_pos(i)).X = problem.departments(hit_pos(i)).X + 1;
                      problem.departments(hit_pos(i)).E = problem.departments(hit_pos(i)).E - 1;
                    end
                  end
                end
              else
                %checa se todos os departamentos com os quais haveria obstruÃ§Ã£o podem ser diminuidos
                for i=1:length(hit)
                  if problem.departments(hit_pos(i)).fixed
                    cancel = true;
                  elseif (problem.departments(hit_pos(i)).N == 0) && ((problem.departments(hit_pos(i)).Y == 22) || (problem.departments(hit_pos(i)).S == 0))
                    cancel = true;
                  end
                end
                if not(cancel)
                    problem.departments(dept_number).S = problem.departments(dept_number).S + 1;
                    for i=1:length(hit_pos)
                      if problem.departments(hit_pos(i)).N > 0
                        problem.departments(hit_pos(i)).N = problem.departments(hit_pos(i)).N - 1;
                      elseif ~problem.departments(dept_number).fixedCentroid
                        problem.departments(hit_pos(i)).Y = problem.departments(hit_pos(i)).Y + 1;
                        problem.departments(hit_pos(i)).S = problem.departments(hit_pos(i)).S - 1;
                      end
                    end
                end
              end
          else
            %nÃ£o ta ocupado
            if directions(direction_n) == 'left'
              if (problem.departments(dept_number).X - problem.departments(dept_number).W) > 1
                problem.departments(dept_number).W = problem.departments(dept_number).W + 1;
              end
            elseif directions(direction_n) == 'up'
              if (problem.departments(dept_number).Y - problem.departments(dept_number).N) > 1
                problem.departments(dept_number).N = problem.departments(dept_number).N + 1;
              end
            elseif directions(direction_n) == 'right'
              if (problem.departments(dept_number).X + problem.departments(dept_number).E) < 46
                problem.departments(dept_number).E = problem.departments(dept_number).E + 1;
              end
            else
              if (problem.departments(dept_number).Y + problem.departments(dept_number).S) < 22
                problem.departments(dept_number).S = problem.departments(dept_number).S + 1;
              end
            end
          end
        else
          %diminui
          target = [];
          if ~isempty(problem.constraint)
            target = attract(dept_number, problem.constraint, problem.departments, problem.solution);
          end
          if (problem.departments(i).N + problem.departments(i).S) > (problem.departments(i).E + problem.departments(i).W)
            directions = ["up", "down", "right", "left"];
            if ~isempty(target)
                if ismember("up", target)
                    alfa = alfa + 10;
                end
                if ismember("down", target)
                    alfa = alfa - 10;
                end
                if ismember("right", target)
                    beta = beta + 10;
                end
                if ismember("left", target)
                    beta = beta - 10;
                end
            end
          else
            directions = ["left", "right", "up", "down"];
            if ~isempty(target)
                if ismember("left", target)
                    alfa = alfa + 10;
                end
                if ismember("right", target)
                    alfa = alfa - 10;
                end
                if ismember("up", target)
                    beta = beta + 10;
                end
                if ismember("down", target)
                    beta = beta - 10;
                end
            end
          end



          if problem.req_aspect(problem.solution(dept_number)) <= ach_aspect(problem.solution(dept_number))/2
            direction_prob(1) = (40 + alfa) / 100;
            direction_prob(2) = (40 - alfa) / 100;
            direction_prob(3) = (10 + beta) / 100;
            direction_prob(4) = (10 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) < ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (30 + alfa) / 100;
            direction_prob(2) = (30 - alfa) / 100;
            direction_prob(3) = (20 + beta) / 100;
            direction_prob(4) = (20 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) >= 2*ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (10 + alfa) / 100;
            direction_prob(2) = (10 - alfa) / 100;
            direction_prob(3) = (40 + beta) / 100;
            direction_prob(4) = (40 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) > ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (20 + alfa) / 100;
            direction_prob(2) = (20 - alfa) / 100;
            direction_prob(3) = (30 + beta) / 100;
            direction_prob(4) = (30 - beta) / 100;
          elseif problem.req_aspect(problem.solution(dept_number)) == ach_aspect(problem.solution(dept_number))
            direction_prob(1) = (25 + alfa) / 100;
            direction_prob(2) = (25 - alfa) / 100;
            direction_prob(3) = (25 + beta) / 100;
            direction_prob(4) = (25 - beta) / 100;
          end

          %alfa_array = [alfa_array alfa];
          %beta_array = [beta_array beta];

          %apÃ³s calculadas as probabilidades de cada direÃ§Ã£o, utiliza-se o algoritmo da roleta para selecionar uma
          direction_n = roleta(direction_prob);

          if directions(direction_n) == 'left'
            if problem.departments(dept_number).W > 0
              problem.departments(dept_number).W = problem.departments(dept_number).W - 1;
            else
              if problem.departments(dept_number).E > 0 && ~problem.departments(dept_number).fixedCentroid
                  problem.departments(dept_number).E = problem.departments(dept_number).E - 1;
                  problem.departments(dept_number).X = problem.departments(dept_number).X + 1;
              end
            end
          elseif directions(direction_n) == 'up'
            if problem.departments(dept_number).N > 0
              problem.departments(dept_number).N = problem.departments(dept_number).N - 1;
            else
              if problem.departments(dept_number).S > 0 && ~problem.departments(dept_number).fixedCentroid
                  problem.departments(dept_number).S = problem.departments(dept_number).S - 1;
                  problem.departments(dept_number).Y = problem.departments(dept_number).Y + 1;
              end
            end
          elseif directions(direction_n) == 'right'
            if problem.departments(dept_number).E > 0
              problem.departments(dept_number).E = problem.departments(dept_number).E - 1;
            else
              if problem.departments(dept_number).W > 0 && ~problem.departments(dept_number).fixedCentroid
                  problem.departments(dept_number).W = problem.departments(dept_number).W - 1;
                  problem.departments(dept_number).X = problem.departments(dept_number).X - 1;
              end
            end
          else
            if problem.departments(dept_number).S > 0
              problem.departments(dept_number).S = problem.departments(dept_number).S - 1;
            else
              if problem.departments(dept_number).N > 0 && ~problem.departments(dept_number).fixedCentroid
                  problem.departments(dept_number).N = problem.departments(dept_number).N - 1;
                  problem.departments(dept_number).Y = problem.departments(dept_number).Y - 1;
              end
            end
          end


        end
    end
    %swap
%{
    x = rand;
    aux = [];
    if x <= 0.05
      a = randi(length(problem.departments));
      b = randi(length(problem.departments));
      while problem.departments(a).fixed
        a = randi(length(problem.departments));
      end

      while problem.departments(b).fixed
        b = randi(length(problem.departments));
      end
      aux = problem.req_area(a);
      problem.req_area(a) = problem.req_area(b);
      problem.req_area(b) = aux;

      aux = problem.solution(a);
      problem.solution(a) = problem.solution(b);
      problem.solution(b) = aux;
    end
%}


    %ach_adj = req_adj;
    %ach_align = req_align;

    %formula de minimizaÃ§Ã£o final = value1 + value2 + value3 + penalty penalty = value4 + value5 ===> final = value1 + value2 + value3 + value4 + value5
    value1 = 0;
    value2 = 0;
    value3 = 0;
    dist = zeros(length(problem.departments));
    for i=1:length(problem.departments)
      for j=1:length(problem.departments)
        dist(i, j) = abs(problem.departments(i).X - problem.departments(j).X) + abs(problem.departments(i).Y - problem.departments(j).Y);
        value1 = value1 + (problem.weight_factor(1) * problem.materials(problem.solution(i), problem.solution(j)) * problem.costs(problem.solution(i), problem.solution(j)) * dist(i, j));
      end
      value2 = value2 + (problem.weight_factor(2) * (abs(problem.req_area(i) - ach_area(i)) / problem.req_area(i)));
      value3 = value3 + (problem.weight_factor(3) * (abs(problem.req_aspect(problem.solution(i)) - ach_aspect(problem.solution(i)))));
    end
    value4 = 0;
    value5 = 0;
    for i=1:(length(problem.departments) - 1)
      for j=(i + 1):length(problem.departments)
        value4 = value4 + (problem.weight_factor(4) * problem.req_adj(problem.solution(i), problem.solution(j))*(1 - ach_adj(problem.solution(i), problem.solution(j))));
        value5 = value5 + (problem.weight_factor(5) * problem.req_align(problem.solution(i), problem.solution(j))*(1 - ach_align(problem.solution(i), problem.solution(j))));
      end
    end
    final = value1 + value2 + value3 + value4 + value5;


    sol_final = zeros(problem.dimY, problem.dimX);
    for i=1:length(problem.departments)
      %length(departments)
      for j=(problem.departments(i).X - problem.departments(i).W):(problem.departments(i).X + problem.departments(i).E)
        for k=(problem.departments(i).Y - problem.departments(i).N):(problem.departments(i).Y + problem.departments(i).S)
          try
            sol_final(k, j) = problem.solution(i);
          catch ME
            error(sprintf('erro: %f %f %f %f %f %f %f %f %f', i, j, k, problem.departments(i).X, problem.departments(i).Y, problem.departments(i).N, problem.departments(i).E, problem.departments(i).S, problem.departments(i).W))
          end
        end
      end
    end

    area_desoc = 0;
    area_oc = 0;
     for i = 1:problem.dimX
        for j = 1:problem.dimY
            if sol_final(j, i) == 0
                area_desoc = area_desoc + 1;
            else
                area_oc = area_oc + 1;
            end
        end
     end
    value6 = 20*area_desoc;
    final = final + value6;



    if final_recovery ~= 0
        if final > final_recovery
            freq = 0;
              aux = rand;
              P = (0.95 + (iteracoes * 0.001));
              if P > 1
                P = 1;
              end
              if aux > P
                final = final_recovery;
                problem = problem_recovery;
              end
        else
          if abs(final-final_recovery) <= 0.01*final
              if freq == 30
                finish = true;
              else
                  freq = freq + 1;
              %freq = freq + 1;
              %freq = 0;
              end

%{
          finish = true;
          %req_align
          %ach_align
          for i=1:length(problem.departments)
            for j=1:length(problem.departments)
              if ((problem.req_align(i,j) == 1) && (ach_align(i,j) == 0))
                finish = false;
              end
            end
          end
%}
          else
              freq = 0;
          end
        end
    end
    final_recovery = final;
    problem_recovery = problem;
    tempo = toc;
    iteracoes = iteracoes + 1;


    if teste == 60
    %  finish = true;
    end
  end
end
