result = 1000000;


for i = 1:100
    result_aux = main(departments, constraints, materials, costs, [ 0.00000001 20 10 20 400]);
    if result_aux < result
        weight = [ 0.00000001 20 10 20 400];
        result = result_aux;
    end
end

for i = 1:100
    result_aux = main(departments, constraints, materials, costs, [ 0.00000001 30 10 20 400]);
    if result_aux < result
        weight = [ 0.00000001 30 10 20 400];
        result = result_aux;
    end
end

for i = 1:100
    result_aux = main(departments, constraints, materials, costs, [ 0.00000001 40 10 20 400]);
    if result_aux < result
        weight = [ 0.00000001 40 10 20 400];
        result = result_aux;
    end
end

for i = 1:100
    result = main(departments, constraints, materials, costs, [ 0.00000001 50 10 20 400]);
    if result_aux < result
        weight = [ 0.00000001 50 10 20 400];
        result = result_aux;
    end
end

for i = 1:100
    result_aux = main(departments, constraints, materials, costs, [ 0.00000001 60 10 20 400]);
    if result_aux < result
        weight = [ 0.00000001 60 10 20 400];
        result = result_aux;
    end
end

for i = 1:100
    result_aux = main(departments, constraints, materials, costs, [ 0.00000001 10 5 20 400]);
    if result_aux < result
        weight = [ 0.00000001 10 5 20 400];
        result = result_aux;
    end
end