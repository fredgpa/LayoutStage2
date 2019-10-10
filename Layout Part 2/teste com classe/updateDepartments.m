function [ departments ] = updateDepartments(departments, cromossome)
    crom_count = 3 + centroid(1) + centroid(2 + centroid(1));
    for(i = 1; i <= length(departments))
        departments(i).setCentroid(cromossome(crom_count), cromossome(crom_count + 1));
        crom_count = crom_count + 2;
    end
end