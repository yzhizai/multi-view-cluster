function Y = kPA(X, p, sigma_range)
%Usage: Y = KPA(X, p, sigma_range)
%kPA is the algorithm following the paper:Jorgensen, K.W., Hansen, L.K., 2012. Model selection for gaussian kernel PCA denoising.
%which is used to select the appropriate parameters for kPCA with guassian
%kernel. The parameters include the guassian sigma and number of
%components.
%
%Input: 
%  X - the observation matrix with rows represent the observation, and
%  columns represent the features.
%  p - the number of replicas to generate the 95 percentile.
%  sigma_range -  the range of sigma to choose from.
%Output:
%  Y - the results same to the output of kPCA function, it is the componts
%  wanted.
%
%Institute of High Energy
%Shaofeng Duan
%2017-2-19
X_perm = X;
[ob_no, pa_no] = size(X);
for aa = 1:p
    for bb = 1:pa_no
        permOrder = randperm(ob_no)';
        temp = X;
        temp(:, bb) = temp(permOrder, bb);
    end
    X_perm = cat(3, X_perm, temp);
end

X_perm_cell = reshape(mat2cell(X_perm, ob_no, pa_no, ones(1, p + 1)), p + 1, 1);

q_sigma = zeros(numel(sigma_range), 1);
E_sigma = zeros(numel(sigma_range), 1);
ee = 1;
for cc = sigma_range
   % calculate each X and its replicas kPCA
   [~, ~, eigVal]  = cellfun(@(x) kPCA(x, 10, 'gaussian', cc), X_perm_cell, 'UniformOutput', false);
   eigVal_r = real(cat(2, eigVal{:}));
   eigVal_head10 = eigVal_r(1:10, :);
   perc_95 = eigVal_head10(:, 2:end);

   for dd = 1:size(perc_95, 1)
       temp = perc_95(dd, :);
       temp_sort = sort(temp);

       perc_val(dd) = temp_sort(46);
   end
   eigVal_orig = eigVal_head10(:, 1);
   figure
   plot(eigVal_orig)
   hold on
   plot(perc_val)
   hold off
   contra_orig_perm = eigVal_orig - perc_val';
   L_inx = find(contra_orig_perm < 0);
   if ~isempty(L_inx)
       q_sigma(ee) = L_inx(1) - 1;
   else
       q_sigma(ee) = 10;
   end
   
   E_sigma(ee) = sum(contra_orig_perm(1:q_sigma(ee) - 1)); % to calculate the signal energy corresponding to sigma value.
   ee = ee + 1;
end
figure
plot(sigma_range, E_sigma)

[~, idx] = max(E_sigma);

sigma_select = sigma_range(idx);
q_select = q_sigma(idx) - 1;
[Y, ~, ~] = kPCA(X, q_select, 'gaussian', sigma_select);

   