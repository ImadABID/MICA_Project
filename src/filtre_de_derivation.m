function dx = filtre_de_derivation(x)
    dx = zeros(1, length(x));
    dx(1) = 2*x(2) + x(3);
    dx(2) = -2*x(1) + 2*x(3) + x(4);
    for i = 3:1:length(x)-2
        dx(i) = -x(i-2) -2*x(i-1) +2*x(i+1) +x(i+2);
    end
    dx(length(x)-1) = -x(length(x)-3) -2*x(length(x)-2) +2*x(length(x));
    dx(length(x)) = -x(length(x)-2) -2*x(length(x)-1);
end

