function [ prob ] = deptProb_Flow(departments, materials)
    
    n = length(departments);
    prob = zeros(1, n);
    flow = zeros(1, n);
    for i=1:n
        if ~departments(i).fixedPos
            for j=1:length(materials(departments(i).n, :))
                dist = abs((departments(i).centroidX - departments(findDepartment(departments, j)).centroidX)) + abs((departments(i).centroidY - departments(findDepartment(departments, j)).centroidY));
                flow(departments(i).n) = flow(departments(i).n) + (materials(departments(i).n, j)*dist);
            end
        end
    end
    totalFlow = sum(flow, 'all');
    for i=1:n
        prob(i) = flow(i)/totalFlow;
    end
end