function [index]=CPI(Y,NUM)
%=====================================================================
% Programmer: 
% Dharambhai Shah et.al., E-mail: shahdharam7@gmail.com
%======================================================================
%  Input
%  Y is L-by-N data matrix where L is the spectral bands (or observations) and N is the number of pixels (data length).   
%  NUM is the number of pure pixel in the image Y.
%----------------------------------------------------------------------
%  Output
%  PP_Index is the set of NUM purest pixel indices
%========================================================================

[Bands,num] = size(Y);

target=[];
score_tar=zeros(num,1);
for i=1:1:Bands
    for j=(i+1):1:Bands
        n_x1=i;
        n_y1=j;
        x1=Y(n_x1,:)';
        y1=Y(n_y1,:)';
        co=convhull(x1,y1);
        co(end,:)=[];
        n_co=size(co);
            for k=1:n_co
                n_tar=size(target);
                flag=0;
                for k1=1:n_tar
                    if(co(k)==target(k1))
                        score_tar(k1)=score_tar(k1)+1;
                        flag=1;
                    end
                end
                if(flag==0)
                    target=[target;co(k)];
                end
            end
    end
end

for i=1:NUM
    [m1,m2]=max(score_tar);
    index(i)=target(m2);
    target(m2)=[];
    score_tar(m2)=[];
end

end