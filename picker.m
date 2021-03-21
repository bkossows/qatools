function picker(data)
param_set=[1,4,6,11,44];

set(gcf,'userdata',[])
    for j = 1:numel(param_set)
        subplot(1,numel(param_set),j)
        for i = 1:size(data,1)
            handle(j,i)=line(0,data(i,param_set(j)),'marker','.','userdata',i,'ButtonDownFcn',@highlight);
        end
        title(num2str(param_set(j)));
    end

function highlight(gcbo, EventData, handles)
    big=20;
    defsize=6;
    current=get(gcf,'userdata');
    new=get(gcbo,'userdata');
    
    for k=1:size(handle,1)       
        set(handle(k,current),'MarkerSize',defsize,'Color','blue');
        set(handle(k,new),'MarkerSize',big,'Color','red');
    end
    set(gcf,'userdata',new);
end

end