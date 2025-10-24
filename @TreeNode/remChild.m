function remChild(node, child)
% Remove child from a node
%
% Removes the specified child from the node's children list. The
% child does not have a parent.
arguments (Input)
	node (1,1) TreeNode
	child (1,1) TreeNode
end
if child.parent ~= node
	error( ...
		"TreeNode:remChild", ...
		"node is not parent of child");
else
	node.children = child.getSiblings();
end
end