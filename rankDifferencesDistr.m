function threshold = rankDifferencesDistr(N,K,alpha)

%K is the number of sequence repetitions in one block
%N is the number of items in the sequence
%alpha is the desired rate of type 1 error

for ns = 1:length(N)
    p=ones(1,N(ns))/N(ns);% uniform distribution

    for ks = 1:length(K)
        cy = p;
        for kk = 1:K(ks)-1
            cy=[0 conv(cy,p)];
        end
        
        dy=conv(cy,cy);
        expValue=sum(dy.*[1:length(dy)]);
        dx=[1:length(dy)]-expValue;
        f=find(cumsum(dy)<=alpha,1,'last');
        threshold(ns,ks)=dx(f); 
    end
end
