input: maximas_I, maximas_M

unused_maximas_I = maximas_I
unused_maximas_M = maximas_M
costlog = []
Maximum_I = getMaximum(unused_maximas_I)
//remove the image maximum from the unused maximas list 
remove(unused_maximas_I, Maximum_I)
//if the model maximas > 0.8 * Maximum_I, then it will be chosen
//as candidate to match with.
max_candidates = getCand(Maximum_I, unused_maximas_M) 
//for loop
for (cand : max_candidates) 
    //for second maximum of the image, we do the same, 
	//get the candidates in unused model maximas
	remove(unused_maximas_M,cand)	
    sMaximum_I = getMaximum(unused_maximas_I)
	smax_candidates = getCand(sMaximum_I, unused_maximas_M)
	temp_I = unused_maximas_I
	temp_M = unused_maximas_M
	for(scand : smax_candidates)
        remove(unused_maximas_M,scand)
		reuse the CSS algorithm matching steps 3~6 from the paper "Image Similarity Retrieval"
		append the cost to costlog 
    end
end

get the minimum of the costlog

reverse image and model and undergo the algorithm again, and return the smaller cost as final result.
	
