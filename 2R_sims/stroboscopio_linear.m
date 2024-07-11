
syms q1 q2 


l1=1;
l2=1;
l3=1;


p1=[l1*cos(q1);
    l1*sin(q1)];

p2=[l1*cos(q1)+l2*cos(q1+q2);
    l1*sin(q1)+l2*sin(q1+q2)];


figure;

linea_disegnata1=[];

axis([-3 4 -0.5 3]) 
axis equal

signal_len = length(out.simout(:,1));
modulus_ = round(signal_len/50);

hold on
n=0;
% Generate the color interpolation from blue to red
% zeros(signal_len, 1)
%colors = [linspace(1, 0, signal_len)', linspace(0, 1, signal_len)', zeros(signal_len, 1)];
colors = viridis(signal_len/modulus_);
k = 1;
for i=1:length(out.simout(:,1))
    
    if mod(i,modulus_)==0
        
        n=n+1;
        
        punto_1=double(subs(p1,q1,out.simout(i,1)));
        

        punto_2=double(subs(p2,[q1 q2],[out.simout(i,1),out.simout(i,2)]));

        linea_disegnata1(:,n)=punto_2;
        % if i<length(out.simout(:,1))/3
        line([0,punto_1(1),punto_2(1)],[0,punto_1(2),punto_2(2)],color=colors(k,:),LineWidth=2);
        scatter(punto_1(1), punto_1(2),20, colors(k,:),"filled"); % Joint 0
        scatter(punto_2(1), punto_2(2),20, colors(k,:),"filled"); % Joint 0

        k=k+1;

        % plot_robot(out.simout(i,:)')


    end
end




ln2=line(linea_disegnata1(1,:),linea_disegnata1(2,:),'color','black');
ln2.LineWidth=3;


% % Parameters
% xc = 2.5;  % X-coordinate of the circle center
% yc = 2;    % Y-coordinate of the circle center
% r = 1;     % Radius of the circle
xc = out.geometry(1);
yc = out.geometry(2);
r  = out.geometry(3);

% Create an array of angles from 0 to 2*pi
theta = linspace(0, 2*pi, 100);

% Calculate the x and y coordinates of the circle
x = xc + r * cos(theta);
y = yc + r * sin(theta);

ln3=line(x,y,color = [0.5 0.5 0.5]);
ln3.LineWidth=2;

fill(x, y, [0.5 0.5 0.5]); % [0.5 0.5 0.5] is the RGB color for grey


hold off



figure;

linea_disegnata1=[];

axis([-3 4 -0.5 3]) 
axis equal

signal_len = length(out.simout1(:,1));
modulus_ = round(signal_len/50);

hold on
n=0;
% Generate the color interpolation from blue to red
% zeros(signal_len, 1)
%colors = [linspace(1, 0, signal_len)', linspace(0, 1, signal_len)', zeros(signal_len, 1)];
colors = viridis(signal_len/modulus_);
k = 1;
for i=1:length(out.simout1(:,1))
    
    if mod(i,modulus_)==0
        
        n=n+1;
        
        punto_1=double(subs(p1,q1,out.simout1(i,1)));
        

        punto_2=double(subs(p2,[q1 q2],[out.simout1(i,1),out.simout1(i,2)]));


        linea_disegnata1(:,n)=punto_2;
        % if i<length(out.simout(:,1))/3
        line([0,punto_1(1),punto_2(1)],[0,punto_1(2),punto_2(2)],color=colors(k,:),LineWidth=2);
        scatter(punto_1(1), punto_1(2),20, colors(k,:),"filled"); % Joint 0
        scatter(punto_2(1), punto_2(2),20, colors(k,:),"filled"); % Joint 0
        
        k=k+1;

        % plot_robot(out.simout(i,:)')


    end
end




ln2=line(linea_disegnata1(1,:),linea_disegnata1(2,:),'color','black');
ln2.LineWidth=3;


% Create an array of angles from 0 to 2*pi
theta = linspace(0, 2*pi, 100);

% Calculate the x and y coordinates of the circle
x = xc + r * cos(theta);
y = yc + r * sin(theta);

ln3=line(x,y,color = [0.5 0.5 0.5]);
ln3.LineWidth=2;

fill(x, y, [0.5 0.5 0.5]); % [0.5 0.5 0.5] is the RGB color for grey


hold off



