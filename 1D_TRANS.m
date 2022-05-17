clear
clc

disp('****************************************************')

disp('1D coordinate transformation script')
disp('                                                     ')

disp('The present script is created for the implementation of vertical tranformation')
disp('Model: Observation of equations--> We implement a model best fitting level')
disp('dH=ax+by+c  --> a and b are the inclinations per X and Y axis, c the bias terms, respectively')
disp('(x,y)-->the projection coordinates of the frames')
disp('dH   -->the height differences between the two frames')
disp('                                                     ')
disp('****************************************************')
disp('                                                     ')
disp('we assume diagonal weights with value 1-->Ce =I')
disp('Estimated parameters: a, b, c')
disp('                                                     ')
disp('                                                     ')
disp('some explanations:')
disp('1. The projection coordinates will refer to the initial frame')
disp('2. The dH = refers to the height difference per point between the final and the initial reference frames, respectively')
disp('3. The script transforms the heights from the reference frame A to B')
disp('4. For more details regarding the method, one can consult the book : Surveying Networks and Computations, D. Rossikopoulos 1999, chapter 14')
disp('                                                     ')
disp('****************************************************')


disp('                                                     ')

disp('input files')
disp('Define two *.txt files containing for each point:')
disp('code x y H')

disp('****************************************************')

disp('                                                     ')


disp('Select the coordinate file of the initial frame')


[corA, pathname] = uigetfile('*.txt','Select the coordinate file of the initial frame');
C = textread([pathname corA]);

disp('Now the coordinates of the initial reference frames are stored')

disp('++++++++++++++++++++++++++')



disp('Select the coordinates file of the final frame')

[corB, pathname] = uigetfile('*.txt','Select the coordinates file of the final frame');
D = textread([pathname corB]);

disp('Now the coordinates of the final reference frames are stored')
disp('                                                     ')

disp('++++++++++++++++++++++++++')

disp('XXXXXXXXXXX     ESTIMATION PROCEDURE   XXXXXXXXXXXXXXX')

disp('++++++++++++++++++++++++++')


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



x0=C(:,2);
y0=C(:,3);
h0=C(:,4);

x=x0;
y=y0;
h=h0;


X=D(:,2);
Y=D(:,3);
H=D(:,4);

n=length(x);

k0=0;

for i=1:n
    A(i,:)=[x(i) y(i) 1];
end


for i=1:n
    Ce(i)=1;
    b(i)=H(i)-h(i);
end

Ce=diag(Ce);

N=A'*inv(Ce)*A;
u=A'*inv(Ce)*b';

dx=inv(N)*u;

e=b'-A*dx;

    H_ad=h0+A*dx;


 
disp('++++++++++++++++++++++++++')

disp('The estimated parameters are (a radians, b radians, c meters')

a=dx(1)
b=dx(2)
c=dx(3)

disp('                                                     ')

disp('++++++++++++++++++++++++++')

disp('                                                     ')

disp('The transformed heights of the initial frame are (code, X, Y in meters)')

[C(:,1) C(:,2) C(:,3) H_ad]

disp('                                                     ')

disp('++++++++++++++++++++++++++')


disp('                                                     ')

disp('The estimated residuals are (code, height -in meters-)')

 
[C(:,1) e]





