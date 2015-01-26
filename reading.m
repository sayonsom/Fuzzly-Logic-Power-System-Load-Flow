PV_no=0;
for(ibus=1:busno)
    bustype(ibus)=busdata(ibus,2);
    delta(ibus)=-0.0;
    if bustype(ibus)==2
        v(ibus)=1;
        PV_no=PV_no+1;
    else
        v(ibus)=busdata(ibus,3);
    end
    
end



