cate_count = load('SR_testData\\MPEGdata\\catecount.log');
result = zeros(length(cate_count),5);
for i = 1:length(cate_count)
    if(i==1)
        input_index = 1;
    else    
        input_index = 1 + sum(cate_count(1:i-1)); 
    end    
    [p5,p10,p20,recall] = Search(input_index, 0, cate_count);
    result(i,1) = recall;
    result(i,2) = recall*1.0/cate_count(i);
    result(i,3) = p5;
    result(i,4) = p10;
    result(i,5) = p20;
    disp(['index: ', num2str(input_index),': ',num2str(p5), ',',num2str(p10),',',num2str(p20)]);
end