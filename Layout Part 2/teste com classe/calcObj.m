function value = calcObj(departments, constraints)

    for i = 1:length(constraints)
        deptA = findDepartment(departments, constraints(i).deptA);
        deptB = findDepartment(departments, constraints(i).deptB);
        constraints(i) = constraints(i).constraintCheck( departments(deptA), departments(deptB));
    end
    
    value1 = 0;
    value2 = 0;
    value3 = 0;
    dist = zeros(length(departments));
    for i=1:length(departments)
      for j=1:length(departments)
        dist(i, j) = abs((departments(i).centroid_X - departments(j).centroid_X)) + abs((departments(i).centroid_Y - departments(j).centroid_Y));
        value1 = value1 + (materials(departments(i).n, departments(j).n) * costs(departments(i).n, departments(j).n) * dist(i, j));
      end
      value2 = value2 + ( (abs(departments(i).req_Area - departments(i).calcArea) / departments(i).req_Area);
      value3 = value3 + (abs(departments(i).req_Aspect - departments(i).calcAspect()));
    end
    
    value4 = 0;
    value5 = 0;
    for i=1:(length(departments) - 1)
        value4 = value4 + ( req_adj(departments(i).n, departments(j).n)*(1 - ach_adj(i, j)));
       value5 = value5 + ( req_align(departments(i).n, departments(j).n)*(1 - ach_align(i, j)));
    end
    value = weight_factor(1) * value1 + weight_factor(2) * value2 + weight_factor(3) * value3 + weight_factor(4) * value4 + weight_factor(5) * value5;
   

end