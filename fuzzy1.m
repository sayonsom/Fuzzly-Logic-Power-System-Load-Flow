


function [out]= fuzzy(in1,in2,in1max,in2max,outmax)

num_in1=5;
num_in2=5;
num_out=5;

g1=in1max;
g2=in2max;
g0=outmax;

     nb_f=[-inf       -1      -0.5];
     nm_f=[-0.75      -0.375  0];
     ze_f=[-0.25      0       0.25];
     pm_f=[0          0.375   0.75];
     pb_f=[0.5        1       inf];
     
     memfunc=[nb_f 
              nm_f;
              ze_f;
              pm_f;
              pb_f;];
          

nb=-1;nm=-0.375;ze=0;pm=0.375;pb=1;       %centres of membership-functions

c_in1=[nb nm ze pm pb]*g1;     
c_in2=[nb nm ze pm pb]*g2;
c_out=[nb nm ze pm pb]*g0;

rules1=[nb nb nm ze pm;
       nb nm nm ze pm;
       nm nm ze pm pm;
       ze ze pm pm pb;
       pm pm pm pb pb;]*g0;
rules=transpose(rules1);
   
count1=0;count2=0;
   
   if in1<c_in1(1)		%for left saturation
         mfe=[1 0 0 0 0]; 
	 count1=count1+1;
     hit1=1; 	  
     
	elseif in1>=c_in1(num_in1)		%for right saturation		  
	 mfe=[0 0 0 0 1];
	 count1=count1+1;hit1=num_in1; 
     
   else                                 %for general
	   for j=1:num_in1
		 if in1==c_in1(j)
             mfe(j)=1;
             count1=count1+1;
			 hit1=j;
         elseif in1<c_in1(j)
            halfbase1=g1*(memfunc(j,2)-memfunc(j,1));
		   mfe(j)=max([0 1+(in1-c_in1(j))/halfbase1]);   
		  				
			if mfe(j)~=0	
			 count1=count1+1;
			 hit1=j;	
			end
         else 
           halfbase1=g1*(memfunc(j,3)-memfunc(j,2));   
		   mfe(j)=max([0,1+(c_in1(j)-in1)/halfbase1]); 
		  						
			if mfe(j)~=0
			 count1=count1+1;   
			 hit1=j;  
			end
		 end
		end
   end
    
   
   
   if in2<c_in2(1)		%for left saturation
         mfc=[1 0 0 0 0]; 
         count2=count2+1;hit2=1; 	  
     
	elseif in2>=c_in2(num_in2)		%for right saturation		  
            mfc=[0 0 0 0 1];
            count2=count2+1;hit2=num_in2; 
     
   else                                 %for general
	   for j=1:num_in2
		 if in2==c_in2(j)
             mfc(j)=1;
             count2=count2+1;
			 hit2=j;
         elseif in2<c_in2(j)
            halfbase2=g2*(memfunc(j,2)-memfunc(j,1));
            mfc(j)=max([0 1+(in2-c_in2(j))/halfbase2]);   
		  				
			if mfc(j)~=0	
			 count2=count2+1;
			 hit2=j;	
			end
         else 
            halfbase2=g2*(memfunc(j,3)-memfunc(j,2));
            mfc(j)=max([0,1+(c_in2(j)-in2)/halfbase2]); 
		  						
			if mfc(j)~=0
			 count2=count2+1;   
			 hit2=j;  
			end
		 end
		end
   end
   
   
   
num=0;
den=0;

	for k=(hit1-count1+1):hit1	
		for l=(hit2-count2+1):hit2
            
			p=rules(k,l);
            
                if p==c_out(1)||p==c_out(num_out)
                    baseout=g0*abs(nb_f(3));
                else
                    for m=2:(num_out-1)
                        if p==c_out(m)
                            baseout=g0*(memfunc(m,3)-memfunc(m,2));
                        end
                    end
                end
		  prem=min([mfe(k) mfc(l)]);           
          num=num+p*baseout*(prem-(prem)^2/2);
          den=den+baseout*(prem-(prem)^2/2);

       end
    end
    
out=(num/den);
