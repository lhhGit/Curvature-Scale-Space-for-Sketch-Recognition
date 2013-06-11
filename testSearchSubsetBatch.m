cate_count = load('SR_testData\\MPEGdata\\catecount.log');
result = zeros(length(cate_count),5);
for i = 1:length(cate_count) 
    if(i==1)
        start_index = 1;
    else    
        start_index = 1 + sum(cate_count(1:i-1)); 
    end
    count = cate_count(i);
    p5sum = 0;  p10sum = 0;  p20sum = 0; recallsum = 0;
    for j = start_index:start_index+count-1
        disp('Search:');
        [p5,p10,p20,recall] = Search(j, 0, cate_count);
        p5sum = p5sum + p5;
        p10sum = p10sum + p10;
        p20sum = p20sum + p20;
        recallsum = recallsum + recall;
    end
    result(i,1) = recallsum*1.0/count;
    result(i,2) = result(i,1)*1.0/count;
    result(i,3) = p5sum*1.0/count;
    result(i,4) = p10sum*1.0/count;
    result(i,5) = p20sum*1.0/count;
    disp(['index: ', num2str(input_index),': ',result(i,1)]);
end