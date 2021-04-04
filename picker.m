function picker(data,param_set,legend,list)

if nargin<2
    param_set=1;
    legend='first';
    list=repmat('unknown',size(data,1),1);
end

outlier=sum(isoutlier(data(:,param_set)),2)>0;

set(gcf,'userdata',[])
    for j = 1:numel(param_set)
        subplot(1,numel(param_set),j)
        for i = 1:size(data,1)
            if outlier(i)
                handle(j,i)=line(0,data(i,param_set(j)),'marker','*','userdata',i,'ButtonDownFcn',@highlight);
            else
                handle(j,i)=line(0,data(i,param_set(j)),'marker','.','userdata',i,'ButtonDownFcn',@highlight);
            end
        end
        title(legend(j));
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
    fprintf('%s\n',list(new,:));
    sgtitle(list(new,:))
end

end