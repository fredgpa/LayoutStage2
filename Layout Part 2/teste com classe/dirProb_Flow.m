function prob = dirProb_Flow(departments, dept_number, materials)
    prob = [0 0 0 0];
    for i = 1:length(materials(dept_number, :))
        if materials(dept_number, i) > 0
            if departments(dept_number).centroidX < departments(i).centroidX
                prob(2) = prob(2) + materials(dept_number, i);
            elseif departments(dept_number).centroidX > departments(i).centroidX
                prob(4) = prob(4) + materials(dept_number, i);
            end
            
            if departments(dept_number).centroidY < departments(i).centroidY
                prob(3) = prob(3) + materials(dept_number, i);
            elseif departments(dept_number).centroidY > departments(i).centroidY
                prob(1) = prob(1) + materials(dept_number, i);
            end
        end
    end
    
    totalValue = sum(prob);
    for i = 1:4
        prob(i) = prob(i)/totalValue;
    end
end