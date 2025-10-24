function addChild(node, child)
% Add a child to the specified node.
%
% Appends a child to the specified node. Errors if the child
% already exists in the node's children list.
arguments (Input)
	node (1,1) TreeNode
	child (1,1) TreeNode
end
if isempty(node.children)
	node.children = child;
elseif any(node.children == child)
	error( ...
		"TreeNode:addChild", ...
		"child already exists in children list");
else
	node.children = [node.children; child];
end
end