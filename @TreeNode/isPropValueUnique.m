function flag = isPropValueUnique(propName, propValue, nodes)
% Check if a property value is unique among the specified nodes.
%
% Returns true if the specified property value is unique or not
% present in the array of nodes provided, false otherwise.
arguments (Input)
	propName (1,1) string
	propValue
	nodes (:,1) TreeNode
end
arguments (Output)
	flag (1,1) logical
end
treeValues = {nodes.(propName)}';
equalities = cellfun(@(x) isequal(x, propValue), treeValues);
flag = sum(equalities) <= 1;
end