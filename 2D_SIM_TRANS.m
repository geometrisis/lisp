
clear
clc

disp('****************************************************')

disp('2D coordinate transformation script')
disp('                                                     ')

disp('The present script is created for the implementation of 2D similarity tranformation')
disp('Model: Observation of equations')
disp('Model: X=cx+dy+tx')
disp('     : Y=-dx+cy+ty')
disp('(x,y)-->initial frame coordinates')
disp('(X,Y)-->final frame coordinates')
disp('we assume diagonal weights with value 1-->Ce =I')
disp('Estimated parameters: c, d, tx, ty')
disp('                                                     ')



disp('****************************************************')


disp('                                                     ')

disp('input files')
disp('For both frames: a *.txt file containing for each point:')
disp('code x y')

disp('****************************************************')

disp('                                                     ')


disp('outputs')
disp('1. estimated parameters')

disp('                                                     ')
disp('2. transformed coordinates of the initial frame wrt the final one')
disp('                                                     ')

disp('3. the adjusted residuals')
disp('                                                     ')
disp('****************************************************')

disp('                                                     ')


disp('Select the coordinate file of the initial frame')


[corA, pathname] = uigetfile('*.txt','Select the coordinate file of the initial file');
C = textread([pathname corA]);

disp('Now the coordinates of the initial reference frames are stored')

disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')



disp('Select the coordinates file of the final frame')

[corB, pathname] = uigetfile('*.txt','Select the coordinates file of the final frame');
D = textread([pathname corB]);

disp('Now the coordinates of the final reference frames are stored')
disp('                                                     ')

disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')

disp('XXXXXXXXXXX     ESTIMATION PROCEDURE   XXXXXXXXXXXXXXX')

disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')


disp('                                                     ')


load s_cor_A.txt
load s_cor_B.txt

x0=C(:,2);
y0=C(:,3);


x=x0;
y=y0;


X=D(:,2);
Y=D(:,3);


n=length(x);

k0=0;

for i=1:n
    A1(i,:)=[x(i) y(i) 1 0];
    A2(i,:)=[y(i) -x(i) 0 1];
end


b=[X;Y];

A=[A1;A2];

for i=1:n
    Cex(i)=1;
    Cey(i)=1;
end

Cex=diag(Cex);
Cey=diag(Cey);

Ce=[Cex zeros(n,n);zeros(n,n) Cey];

N=A'*inv(Ce)*A;
u=A'*inv(Ce)*b;

dx=inv(N)*u;

e=b-A*dx;

for i=1:n
    X_ad(i)=dx(1)*C(i,2)+dx(2)*C(i,3)+dx(3);
    Y_ad(i)=-dx(2)*C(i,2)+dx(1)*C(i,3)+dx(4);
end



for i=1:n
    ex(i)=e(i);
end

p=n+1;
 
for i=p:(2*n)
    ey(i)=e(i);
end

disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')

disp('The estimated parameters are (tx -meters-, ty-meters-, c, d)')

tx=dx(3)
ty=dx(4)
c=dx(1)
d=dx(2)

disp('                                                     ')

disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')

disp('                                                     ')

disp('The transformed coordinates of the initial frame are (code, X, Y in meters)')

[C(:,1) X_ad' Y_ad']

disp('                                                     ')

disp('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX')


disp('                                                     ')

disp('The estimated residuals are (code, x, y in meters)')

 
[C(:,1) ex' ey']







