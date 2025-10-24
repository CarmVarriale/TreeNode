function flag = isAncestorOf(node, checkNode)
% Check if a node is ancestor of another node
arguments (Input)
	node (1,1) TreeNode
	checkNode (1,1) TreeNode
end
arguments (Output)
	flag (1,1) logical
end
flag = any(node == checkNode.getAncestors());
end
