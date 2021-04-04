%%T1w

legend=[{'cjv'},{'cnr'},{'efc'},{'fber'},{'fwhm avg'},{'qi2'},{'snr total'},{'wm2max'}];
param_set=[1:5,16,29,68];

readT1w
picker(data,param_set,legend,list)

data_sel=data(:,param_set);
outs=isoutlier(data_sel);

f=fopen('outliers_T1w.tsv','w');
for i=1:size(data,1)
fprintf(f,'%s\t%s\n',list(i),strjoin(legend(outs(i,:)),','));
end
fclose(f);

%%BOLD
t1w_list=list; t1w_legend=legend; t1w_outs=outs;


legend=[{'fd mean'},{'fd perc'},{'ghost'},{'tsnr'}];
param_set=[9,11,18,44];

readBold;


picker(data,param_set,legend,list)

data_sel=data(:,param_set);
%upper thresholding
data_sel(:,strcmp(legend,'tsnr'))=-data_sel(:,strcmp(legend,'tsnr'));
outs=isoutlier(data_sel,'percentiles',[0,90]);
%moved volumes above 20%
outs(:,strcmp(legend,'fd perc'))=data_sel(:,strcmp(legend,'fd perc'))>20;

f=fopen('outliers_BOLD.tsv','w');
for i=1:size(data,1)
fprintf(f,'%s\t%s\n',list(i),strjoin(legend(outs(i,:)),','));
end
fclose(f);


%merge func and anat
f=fopen('outliers_merged.tsv','w');
fprintf(f,'struct\twarnings\tfunc1\twarnings\tfunc2\twarnings\tfunc3\twarnings\tfunc4\twarnings\tfunc5\twarnings\tfunc6\twarnings\n');
for i=1:size(t1w,1)
    %anat
    fprintf(f,'%s\t%s',t1w_list(i),strjoin(t1w_legend(t1w_outs(i,:)),','));
    %func
    bold_ind=startsWith(bold.bids_name,erase(t1w.bids_name(i),'_T1w'));
    for j=find(bold_ind)'
        fprintf(f,'\t%s\t%s',list(j),strjoin(legend(outs(j,:)),','));
    end
    fprintf(f,'\n');
end
fclose(f);
