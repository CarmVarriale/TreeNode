function siblings = getSiblings(node)
% Retrieve the siblings of the specified node
%
% Siblings are nodes that share the same parent, and therefore are
% at the same level of the tree hierarchy.
arguments (Input)
	node (1,1) TreeNode
end
arguments (Output)
	siblings (:,1) TreeNode
end
siblings = setdiff(node.parent.children, node, "stable");
end