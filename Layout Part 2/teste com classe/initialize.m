function [departments, constraints] = initialize(problem)

    for i = 1:problem.n
        n = problem.departments(i);
        departments(n) = Department;
        
    end

    
end