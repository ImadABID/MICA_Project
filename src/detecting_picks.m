function picks = detecting_picks(sig, domaines)
    picks = [];
    d_domaines = filter([1 -1], [1], domaines);
    d_domaines = d_domaines(2:1:length(d_domaines));
    i=1;
    while(i <= length(d_domaines))
        if(d_domaines(i)==1)
            imin = i;
            while(d_domaines(i)~=-1 && i < length(d_domaines))
               i = i+1;
            end
            [max_value, max_index] = max(sig(imin:1:i));
            picks = [picks, [imin+max_index-1]];
        end
        i=i+1;
    end
end
