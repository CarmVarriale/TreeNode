function flag = isSiblingOf(node, checkNode)
% Check if a node is sibling of another node
arguments (Input)
	node (1,1) TreeNode
	checkNode (1,1) TreeNode
end
arguments (Output)
	flag (1,1) logical
end
flag = any(node == checkNode.getSiblings());
end