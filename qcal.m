qc=0;delq=0;delqv=0;
for(iqcal=1:busno)
   if(bustype(iqcal)==2)
      qc=qc+1;
      mul=v(iqcal)*exp(-j*delta(iqcal));
   	t=0;
   	for(k=1:busno)
     		t=t+ybus(iqcal,k)*(v(k)*exp(j*delta(k)));
   	end
   	pq=mul*t;
      calq=-imag(pq);
      q=busdata(iqcal,7)-busdata(iqcal,5);
      delq(qc)=q-calq;
      delqv(qc)=delq(qc)/v(iqcal);
      b(qc)=iqcal;
   end
end
[delqmax,q1]=max(abs(delq));
n=b(q1);

sumdelq=sum(delq);


if delqmax>abs(sumdelq)
    sumdelqmax=delqmax;
else
    sumdelqmax=abs(sumdelq);
end
 
max_q_error=sumdelqmax+delqmax;
delvmax=(1/B2(q1))*delqmax;
   

%     if delvmax>0.05
%         delvmax=0.05;
%     end