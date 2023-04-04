%% Solving LMI

A=[0 1 0 0;-48.6 -1.26 48.6 0;0 0 0 10;1.95 0 -1.95 0];
B=[0 21.6 0 0]';
gamma2=(0.333)^2;
setlmis([])
[p,np,sp]=lmivar(1,[4 1]) %P
[tau,ntau,stau]=lmivar(1,[1 1]) %tau
%% First LMI

lmiterm([1 1 1 1],A,1,'s');
lmiterm([1 1 1 2],-1,B*B');
lmiterm([1 1 1 0],gamma2);
lmiterm([1 1 2 1],1,1);
lmiterm([1 2 2 0],-1);
%% Second LMI

lmiterm([-2 1 1 1],1,1);
%% Third LMI

lmiterm([-3 1 1 2],1,1);
LMISYS=getlmis;
%% Results

matnbr(LMISYS)
lminbr(LMISYS)
[tmin,x]=feasp(LMISYS)
pvalue=dec2mat(LMISYS,x,p)
tauvalue=dec2mat(LMISYS,x,tau)
%% Validation

e1=eig(pvalue)
lm1=[A*pvalue+pvalue*A'-tauvalue*B*B'+gamma2*eye(4) pvalue;pvalue -eye(4)];
e2=eig(lm1)
%% New parameters for global consensus

K=-0.5*B'*pvalue^(-1)
c=tauvalue/1.382