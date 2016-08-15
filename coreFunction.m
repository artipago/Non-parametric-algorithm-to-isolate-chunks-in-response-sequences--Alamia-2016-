function [miracleTable,blockMiracle,rtSeqs]=coreFunction(rt,numberSequencePerBlock,lengthSequence)


for ss=1:numberSequencePerBlock
	rtSeqs(ss,:)=rt(((ss-1)*lengthSequence)+1:(ss)*lengthSequence);
end
    
for seqIndex=1:size(rtSeqs,1)
    rtVect=rtSeqs(seqIndex,:);

    rtVect(isnan(rtVect)==1)=nanmean(rtVect);

    [rtVectOrder,indices]=sort(rtVect);
    [indicesSorted,miracle]=sort(indices);
    miracle(rtVect==-Inf)=NaN;
    miracleTableRT(seqIndex,:)=miracle;
   
    rtVectDifference=[];
    rtVectDifference(1)=rtVect(1)-rtVect(2);
    for ii=2:length(rtVect)-1
        rtVectDifference(ii)=rtVect(ii)-nanmean([rtVect(ii+1) rtVect(ii-1)]);
    end
    rtVectDifference(end+1)=rtVect(end)-rtVect(end-1);
       
    rtVectDifference(isnan(rtVectDifference)==1)=nanmean(rtVectDifference);
    [rtVectOrder,indices]=sort(rtVectDifference);
    [indicesSorted,miracle]=sort(indices);
    miracle(rtVectDifference==-Inf)=NaN;
    miracleTableRTdiff(seqIndex,:)=miracle;
end

blockMiracle=[nansum(miracleTableRT)' nansum(miracleTableRTdiff)'];

miracleTable.miracleTableRT=miracleTableRT;
miracleTable.miracleTableRTdiff=miracleTableRTdiff;


