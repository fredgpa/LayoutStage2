function answer = findDepartment(array, dept)
    for i = 1:length(array)
        if array(i).n == dept
            answer = array(i);
        end
    end
end