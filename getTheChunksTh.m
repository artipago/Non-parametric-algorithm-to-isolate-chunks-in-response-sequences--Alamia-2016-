function [chunkItem,posBegin,posEnd,chi]=getTheChunksTh(ranks,finalThreshold,numberSequencePerBlock,lengthSequence)

vectChiDiff=ranks'; %the chi on the difference vect, no on the abs value. 
complementaryVectChi=(numberSequencePerBlock*lengthSequence)*ones(1,length(vectChiDiff))-vectChiDiff;
[p, chi] = chi2([vectChiDiff; complementaryVectChi]);

ranks(isnan(ranks)==1)=nanmean(ranks);

% find the beginning of the chunks
diffRank=diff(ranks);

[sortDiffRank,sortedIndices]=sort(diffRank);
sortDiffRank(sortDiffRank>0)=NaN;

if min(sortDiffRank)<finalThreshold
    
    [a,posDiffMax]=(find(sortDiffRank<finalThreshold));
    headChunk=sort(sortedIndices(1:length(posDiffMax)));
    
    %we kill the consecutives
    difHead=diff(headChunk);
    [a,b]=find(difHead==1);
    headChunk(a+1)=[];

    for ii=1:length(headChunk)
        currentHead=headChunk(ii);
        
        if ii~=length(headChunk)
            nextHead=headChunk(ii+1);
        else
            nextHead=0;
        end
        nextIndex=1;
        flag=0;
        while flag==0
            if (ranks(currentHead+nextIndex)-ranks(currentHead)<=finalThreshold) & currentHead+nextIndex~=nextHead  & abs(ranks(currentHead+nextIndex)-ranks(currentHead+nextIndex-1))<=abs(ranks(currentHead+nextIndex)-ranks(currentHead))% & abs(ranks(currentHead+nextIndex)-ranks(currentHead+nextIndex-1))<= abs(median(abs(diff(ranks)))-ranks(currentHead+nextIndex))   
                nextIndex=nextIndex+1;
            else 
                flag=1;
            end
            if currentHead+nextIndex==length(ranks)+1
                flag=1;
                nextIndex=nextIndex-1;
            end
        end
        if currentHead~=lengthSequence-1
            nextIndex=nextIndex-1;
        end
        tailChunk(ii)=currentHead+nextIndex;
        chunkItem(ii).chunk=headChunk(ii):tailChunk(ii);
        
        chunkItem(ii).score=[ranks(headChunk(ii))/mean(ranks(headChunk(ii)+1:tailChunk(ii)))];

    end
    posBegin=headChunk;
    posEnd=tailChunk;
else
    chunkItem.chunk=NaN;
    chunkItem.score=NaN;
    posBegin=NaN;
    posEnd=NaN;
end


