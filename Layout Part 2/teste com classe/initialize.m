function [departments, constraints] = initialize(problem)

    for i = 1:problem.n_var
        departments(i) = Department;
        departments(i).n = problem.solution(i);
        departments(i).centroidX = problem.departments(i).X;
        departments(i).centroidY = problem.departments(i).Y;
        departments(i).reqArea = problem.req_area(i);
        departments(i).reqAspect = problem.req_aspect(i);
        departments(i).fixedPos = problem.departments(i).fixed;
        departments(i).fixedSize = problem.departments(i).fixed;
        departments(i).sizeU = problem.departments(i).N;
        departments(i).sizeD = problem.departments(i).S;
        departments(i).sizeR = problem.departments(i).E;
        departments(i).sizeL = problem.departments(i).W;
        departments(i) = departments(i).updateDir();
        
    end

    for i=1:length(problem.constraint)
        constraints(i) = Constraint;
        constraints(i).deptA = problem.constraint(i, 1);
        constraints(i).deptB = problem.constraint(i, 2);
        constraints(i).reqAlign = problem.constraint(i, 3);
        constraints(i).achAlign = false;
        constraints(i).achAdj = false;
    end
    
end