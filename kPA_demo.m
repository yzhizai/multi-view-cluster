X = simulated_data(1);

% eigVal = kPA(X, 49, 27);



for bb = 1:5
    eigVal = kPA(X, 49, 24 + bb);
    eigVal_r = real(reshape(eigVal, 1000, []));
    eigVal_head10 = eigVal_r(1:10, :);
    figure(bb)
    plot(1:10, eigVal_head10(:, 1));
    hold on
    perc_95 = eigVal_head10(:, 2:end);

    for aa = 1:size(perc_95, 1)
        temp = perc_95(aa, :);
        temp_sort = sort(temp);

        perc_val(aa) = temp_sort(46);
    end
    plot(1:10, perc_val);
    title(['sigma is ', num2str(24+bb)]);
end