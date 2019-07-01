function prob = dirProb(departments, dept_number, mod, bool)
    aspect = departments(dept_number).calcAspect();
    if bool
        if departments(dept_number).reqAspect <= aspect/2
            alfa = 5;
            beta = 45;
            prob(1) = 5 + alfa*mod(1);
            prob(2) = 5 - alfa*mod(1);
            prob(3) = 45 + beta*mod(2);
            prob(4) = 45 - beta*mod(2);
        elseif departments(dept_number).reqAspect < aspect
            alfa = 15;
            beta = 35;
            prob(1) = 15 + alfa*mod(1);
            prob(2) = 15 - alfa*mod(1);
            prob(3) = 35 + beta*mod(2);
            prob(4) = 35 - beta*mod(2);
        elseif departments(dept_number).reqAspect >= 2*aspect
            alfa = 45;
            beta = 5;
            prob(1) = 45 + alfa*mod(1);
            prob(2) = 45 - alfa*mod(1);
            prob(3) = 5 + beta*mod(2);
            prob(4) = 5 - beta*mod(2);
        elseif departments(dept_number).reqAspect > aspect
            alfa = 35;
            beta = 15;
            prob(1) = 35 + alfa*mod(1);
            prob(2) = 35 - alfa*mod(1);
            prob(3) = 15 + beta*mod(2);
            prob(4) = 15 - beta*mod(2);
        else
            alfa = 25;
            beta = 25;
            prob(1) = 25 + alfa*mod(1);
            prob(2) = 25 - alfa*mod(1);
            prob(3) = 25 + beta*mod(2);
            prob(4) = 25 - beta*mod(2);
        end
    else
        if departments(dept_number).reqAspect <= aspect/2
            prob(1) = 45;
            prob(2) = 45;
            prob(3) = 5;
            prob(4) = 5;
        elseif departments(dept_number).reqAspect < aspect
            prob(1) = 35;
            prob(2) = 35;
            prob(3) = 15;
            prob(4) = 15;
        elseif departments(dept_number).reqAspect >= 2*aspect
            prob(1) = 5;
            prob(2) = 5;
            prob(3) = 45;
            prob(4) = 45;
        elseif departments(dept_number).reqAspect > aspect
            prob(1) = 15;
            prob(2) = 15;
            prob(3) = 35;
            prob(4) = 35;
        else
            prob(1) = 25;
            prob(2) = 25;
            prob(3) = 25;
            prob(4) = 25;
        end
    end
    
end