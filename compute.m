%calculation of specified values of P and Q in each bus

% for PV bus:
for(i=1:busno)
   if(bustype(i)==3)
      qsp(i)=0;
      efi=v(i)*exp(j*delta(i));
      ei=real(efi);
      fi=imag(efi);
      for(k=1:busno)
         efk=v(k)*exp(j*delta(k));
      	 ek=real(efk);
         fk=imag(efk);
         G=real(ybus(i,k));
         B=imag(ybus(i,k));
         qsp(i)=fi*(ek*G-fk*B)-ei*(fk*G+ek*B)+qsp(i);
      end
   end
end

%for Slack bus:
for(i=1:busno)
   if(bustype(i)==1)
      psp(i)=0;
      qsp(i)=0;
      efi=v(i)*exp(j*delta(i));
      ei=real(efi);
      fi=imag(efi);
      for(k=1:busno)
         efk=v(k)*exp(j*delta(k));
      	 ek=real(efk);
         fk=imag(efk);
         G=real(ybus(i,k));
         B=imag(ybus(i,k));
         psp(i)=ei*(ek*G-fk*B)+fi*(fk*G+ek*B)+psp(i);
         qsp(i)=fi*(ek*G-fk*B)-ei*(fk*G+ek*B)+qsp(i);
      end
   end
end

%for PQ bus:
qc=0;
for(i=1:busno)
   if(bustype(i)~=1)
      psp(i)=busdata(i,6)-busdata(i,4);
   end
   if(bustype(i)==2)
      qc=qc+1;
      if(stc~=0)
         for(d=1:stc)
            if(i==store1(d))
               qsp(i)=chq(d);
               break;
            else
               qsp(i)=busdata(i,7)-busdata(i,5);
            end
         end
      else
         qsp(i)=busdata(i,7)-busdata(i,5);
      end
   end
end



