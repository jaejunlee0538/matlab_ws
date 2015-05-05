function  dataSummary( data )
for i=1:1:4
    fprintf('class %d = %d\n',i,sum(data(3,:)==i));
end
fprintf('total : %d\n',length(data));
end

