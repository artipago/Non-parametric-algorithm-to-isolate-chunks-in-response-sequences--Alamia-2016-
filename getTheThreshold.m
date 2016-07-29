function threshold=getTheThreshold(ranks,alpha)

sortDiffRank=ranks;
sortDiffRank(sortDiffRank>0)=[];


% [a,posDiffMax]=max(diff(sortDiffRank));

% allChunks=length(sortDiffRank);

% ii=1;
% flag=0;
% 
% while ii~=length(sortDiffRank) & flag==0
%     if (ii/length(sortDiffRank))>alpha
%         threshold=sortDiffRank(ii);
%         flag=1;
%     else
%         ii=ii+1;
%     end
% end


sortDiffRank=log(abs(sortDiffRank));
x=(1:length(sortDiffRank))./length(sortDiffRank);

m=polyfit(x,sortDiffRank,1);
threshold=alpha*m(1)+m(2)



% figure
% hold on
% plot(sortDiffRank,x)
% plot(sortDiffRank,x,'*')
% plot(threshold,alpha,'r*','LineWidth',4)

threshold=-exp(threshold);



