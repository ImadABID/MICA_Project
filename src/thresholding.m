function out = thresholding(x)
    seuil = mean(x);
    out = (x >= seuil);
end