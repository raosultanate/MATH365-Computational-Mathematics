clear;
clf;

xmin = -50;
xmax = 50;
ymin = -50;
ymax = 50;
bounds = [xmin xmax ymin ymax];


tmin = 0.03;
tmax = 9;
dt = 0.03;
t = [tmin : dt : tmax];
tlevels = length(t);
xtxt = 30;
ytxt = 40;


x = [0 1 -1 0 0];
y = [0 -1 -1 3 0];


sf = @(t) (-0.5*cos(t))+1.5;


x_topright = @(t) 10*t
y_topright = @(t) 10*t
x_topleft = @(t) 10*(9-2*t);
x_center = @(t) 10*(t-9)
y_center = @(t) -10*(t-9)


alpha = @(t) -2*pi*cos(t)+1.5;
R = @(theta) [cos(theta) -sin(theta)
              sin(theta) cos(theta)];
             
A = [x
    y]';

n = 1

while n == 1
   for j = [1:100]
        Anew = sf(t(j))* A *R(alpha(t(j)));
        x = Anew(:,1) + x_topright(t(j));
        y = Anew(:,2) + y_topright(t(j));
        plot(x,y);
        fill(x,y,'m');
        axis('equal');
        axis(bounds);
        M(j) = getframe();
        
        ttext = strcat('t = ', {' '}, num2str(t(j)));
        text(xtxt, ytxt, ttext);
        M(j) = getframe();
   end
   
   for k = [100:200] 
        Anew = sf(t(k)) * A *R(alpha(t(k)));
        x = Anew(:,1) + x_topleft(t(k))
        y = Anew(:,2) + y_topright(t(100));
        plot(x,y);
        fill(x,y,'m');
        axis('equal');
        axis(bounds);
        M(k) = getframe();
       
        ttext = strcat('t = ', {' '}, num2str(t(k)));
        text(xtxt, ytxt, ttext);
        M(k) = getframe();
   end
   
   for m = [200:300]
        Anew = sf(t(m)) * A *R(alpha(t(m)));
        x = Anew(:,1) + x_center(t(m));
        y = Anew(:,2) + y_center(t(m));
        plot(x,y);
        fill(x,y,'m');
        axis('equal');
        axis(bounds);
        M(m) = getframe();
        
        ttext = strcat('t = ', {' '}, num2str(t(m)));
        text(xtxt, ytxt, ttext);
        M(m) = getframe();
   end

end