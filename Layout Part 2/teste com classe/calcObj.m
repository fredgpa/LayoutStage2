function [value, constraintValue, areaValue, aspectValue, departments, constraints] = calcObj(departments, constraints, weight_factor, materials, costs)

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
        dist(i, j) = abs((departments(i).centroidX - departments(j).centroidX)) + abs((departments(i).centroidY - departments(j).centroidY));
        value1 = value1 + (materials(departments(i).n, departments(j).n) * costs(departments(i).n, departments(j).n) * dist(i, j));
      end
      value2 = value2 + (abs(departments(i).reqArea - departments(i).calcArea()) / departments(i).reqArea);
      value3 = value3 + (abs(departments(i).reqAspect - departments(i).calcAspect()));
    end
    
    value4 = 0;
    value5 = 0;
    for i=1:length(constraints)
        value4 = value4 + (1 - constraints(i).achAdj);
        value5 = value5 + constraints(i).reqAlign*(1 - constraints(i).achAlign);
    end
    constraintValue = value4 + value5;
    areaValue = value2;
    aspectValue = value3;
    value = weight_factor(1) * value1 + weight_factor(2) * value2 + weight_factor(3) * value3 + weight_factor(4) * value4 + weight_factor(5) * value5;

end