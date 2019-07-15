function [] = visualize(departments)

    colorPalette = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 1 0 1; 0 1 1; 0 0.4470 0.7410; 0.8500 0.3250 0.0980; 0.9290 0.6940 0.1250; 0.4940 0.1840 0.5560; 0.4660 0.6740 0.1880; 0.3010 0.7450 0.9330; 0.6350 0.0780 0.1840];



    axis([0 46 0 22], 'ij');
    for i = 1:length(departments)
        pos = [(departments(i).centroidX - departments(i).sizeL) (departments(i).centroidY - departments(i).sizeU) (departments(i).sizeL + departments(i).sizeR) (departments(i).sizeU + departments(i).sizeD)];
        rectangle('Position', pos, 'FaceColor', colorPalette(randi(length(colorPalette)), :));
        text(departments(i).centroidX - 1, departments(i).centroidY, num2str(departments(i).n), 'Color', [1 1 1]);
    end

end

