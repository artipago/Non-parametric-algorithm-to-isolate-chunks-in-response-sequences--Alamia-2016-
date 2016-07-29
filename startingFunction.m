function [output]=startingFunction(rtAll,numberSequencePerBlock,lengthSequence,alpha)


finalThreshold = rankDifferencesDistr(lengthSequence,numberSequencePerBlock,alpha); 

[tableMiracle,blockMiracle,rtSeqs]=coreFunction(rtAll,numberSequencePerBlock,lengthSequence);
[chunkItem,posBegin,posEnd,chi]=getTheChunksTh(blockMiracle(:,1),finalThreshold,numberSequencePerBlock,lengthSequence);

output.rtSeqOut=rtSeqs;
output.blockMiracleOut=blockMiracle;
output.chunkItem=chunkItem;
output.posBegin=posBegin;
output.posEnd=posEnd;
output.chi=chi;
output.finalThreshold=finalThreshold;


