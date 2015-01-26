%% Fuzzy Logic Load Flow Program
%% Copyright Sayonsom Chanda 2008

clc
clear all

%businput300
data14


[busno,buscol]=size(busdata);
[lineno,linecol]=size(linedata);
%Read Data from linedata & Busdata :
reading
% Form YBUS :
Ybus

fprintf('Running Fuzzy Load Flow Algorithm for ');fprintf('%1.0f',busno);fprintf('buses \n');
disp('---------------------------------------------------------------------');
disp(' ');

%pasting ll and gg calculation code %
m=1;
n=1;
for(count=1:busno)
   %m=1;
   if busdata(count,2)==2
        ll(1,m)=busdata(count,1);
        m=m+1;
   end
   
   if busdata(count,2)==3
        gg(1,n)=busdata(count,1);
        n=n+1;
   end
   
end

%display(ll);
%display(gg);

%ll , gg code complete%

% yll, ylg, flg matrix formation started%

a=0;b=0;

for(ii_new=1:length(ll))
  a=ll(ii_new);
    for(jj_new=1:length(ll))
        b=ll(jj_new);
        YLL(ii_new,jj_new)=ybus(a,b);
    end
end

for(ii_new=1:length(ll))
  a=ll(ii_new);
    for(jj_new=1:length(gg))
        b=gg(jj_new);
        YLG(ii_new,jj_new)=ybus(a,b);
    end
end

%YLL
%YLG
FLG= -inv(YLL)*YLG;

%yll ylg flg matrix formation complete%


max_itr=400;
tolerance=.001;

r=0;
tic
prev_delpmax=1111110;delpmax=10; delqmax=10;
prev_delqmax=1111110;
kp=1;kq=1;
tstart=tic;
while(r<max_itr)
   %calculation of P ,delp ,delp/delv
   pcal
   
   check_convergence
   
   if kp==1
      improvedel
      while  max_p_error>=prev_delpmax   
          pcal
          improvedel
      end
      prev_delpmax=delpmax;
   end
   
   check_convergence
   qcal
   if delqmax<=tolerance
       kq=0;
   else
       kq=1;
   end

   if(kq==1)
      improvev
      klq=0;
      while   max_q_error>=prev_delqmax 
          qcal
          improvev
          klq=klq+1;
          
      end
      prev_delqmax=delqmax;
   end
   
   check_convergence
      
   r=r+1;
   
end

fprintf('Iteration No. when it converges = ');fprintf('%1.0f',r);


v
Delta
% ybus

% v_load, v_gen etc 
if (busno==14 || busno==30 || busno==57 )
    for(i5=1:length(ll))
        v_load(i5)=v(ll(i5));
        delta_load(i5)=delta(ll(i5));
    end
    for(i6=1:length(gg))
        v_gen(i6)=v(gg(i6));
        delta_gen(i6)=delta(gg(i6));
    end     
end


% display(v_load);
% display(v_gen);
% display(delta_load);
% display(delta_gen);

% v_load, v_gen complete

%reqd theta wala matrix
reqd_theta=zeros(length(ll),length(gg));
for(c=1:length(ll))
    for(d=1:length(gg))
        reqd_theta(c,d)=angle(FLG(c,d));
    end
end
%its done

% L-index

loadbuses=ll;
genbuses=gg;

summm=zeros(1,length(ll));
L=zeros(1,length(ll));
disp(' ');
%display(v);
%display(delta);
% display('----------------------------------------------------------------------------');

% disp('__________________________________');
% disp('Load Bus No.  ||  L-index Value');
% disp('__________________________________');
for(zz=1:length(ll))
    for(yy=1:length(gg))
        angle_sum=reqd_theta(zz,yy)+delta_gen(yy)-delta_load(zz);
        fractionn=v_gen(yy)/v_load(zz);
        voltage_rectangular=fractionn*(cos(angle_sum))+(fractionn*(sin(angle_sum)))*i;
        summm(zz)=summm(zz)+FLG(zz,yy)*voltage_rectangular;
        i;
    end
    L(zz)=abs(1-summm(zz));
     %disp('LJ=');
    fprintf('%5.0f',loadbuses(zz)); fprintf('              %3f \n',L(zz));
    %disp('__________________________________');
    
    
end
[maxValue, rowIdx] = max(L);
fprintf('The weakest bus in the ');fprintf('%1.0f',busno);fprintf(' IEEE System is');fprintf('%3.0f',ll(rowIdx));

% l-index complete
telapsed = toc(tstart)







