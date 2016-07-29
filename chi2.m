function [p, chi] = chi2(values)


for ii = 1:size(values, 1)
    for jj = 1:size(values, 2)
        expected(ii, jj) = (sum(values(ii, :))*sum(values(:, jj)))/sum(sum(values));
    end
end

chi = sum(sum(((values-expected).^2)./expected));
p = 1-chi2cdf(chi, (size(values, 1)-1)*(size(values, 2)-1));
