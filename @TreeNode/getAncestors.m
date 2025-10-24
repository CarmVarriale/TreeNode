function ancestors = getAncestors(node, params)
% Retrieve the ancestors of the specified nodes
%
% Returns all ancestors starting from the parent and proceeding
% recursively until the upTo node is reached.
% If the upTo node is not specified, all nodes up to the root are
% retrieved.
% The ancestors are ordered from the closest to the furthest. This
% means that the root would be the last element of the output
% array. The specified node is not included in the ancestors.
arguments (Input)
	node (1,1) TreeNode
	params.upTo TreeNode {mustBeScalarOrEmpty} = TreeNode.empty
end
arguments (Output)
	ancestors (:,1) TreeNode
end
ancestors = node.parent();
if ~isequal(ancestors, params.upTo)
	ancestors = [
		ancestors;
		ancestors(end).getAncestors( ...
		upTo=params.upTo)];
end
end