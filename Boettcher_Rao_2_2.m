clear;

numer = [10:98];
denom = [11:99];


for i = 1:length(denom)
 
    for j = 1:length(numer)

        if numer(j)> 0 && denom(i) > 0 && numer(j) < denom(i)
           num_Tens = floor(numer(j) / 10);
           num_Ones = mod( numer(j), 10);
                
           denom_Tens = floor(denom(i) / 10);
           denom_Ones = mod( denom(i), 10);
           
           if num_Ones == denom_Tens
               division_cancel = num_Tens/denom_Ones;
               divisionResult_original = numer(j)/denom(i);

               if division_cancel == divisionResult_original
                   fprintf('Your magic numerator is %d with magic denominator is %d\n', numer(j), denom(i));
                   fprintf('Your magic fraction is %d / %d\n', num_Tens, denom_Ones); 
               end
           end
        end
    end
end
