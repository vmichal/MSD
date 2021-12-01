function [t, x] = back_euler(system, x0, tspan, h)
    t = tspan(1) : h : tspan(2);
    x = zeros(length(x0), length(t));
    x(:, 1) = x0;
    
    F = eye(size(system, 1)) - h * system;
    for k = 1 : length(t)-1
        x(:,k+1) = F \ x(:,k);
    end

end
