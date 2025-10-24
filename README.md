# Hierarchical Tree Structure in MATLAB

This MATLAB class provides functionality to create and manage hierarchical tree structures. It allows users to:
- Create nodes in hierarchical parent-child relations
- Add and remove nodes
- Traverse the tree structure and extract information

Every node in the tree has one or no parent, and can have zero or multiple children. 
Only the root node in the tree has no parent.

Nodes are accessed by reference, and can be collected in heterogenous arrays.
This is useful for subclassing the `TreeNode` class to add custom properties or methods to the nodes.


## Installation

Simply download and add the class to your MATLAB path:

```matlab
addpath('path/to/TreeNode');
```

## Usage
### 1. Create a tree with one root, two children, and one grandchild
To create a tree node, instantiate the `TreeNode` class:

```matlab
root = TreeNode();
child1a = TreeNode(root);
child1b = TreeNode(root);
child2a = TreeNode(child1a);
```

### 2. Access parent and children of a node
To access the parent and children of a node:

```matlab
parentNode = child1a.parent;
childrenNodes = root.children;
```

### 3. Explore the tree structure
To explore the tree structure, you can use methods like `getDescendants` or `getAncestors`:

```matlab
descendants = root.getDescendants();
ancestors = child2a.getAncestors();
```

See the class method documentation for more details on available methods and properties.


## Licence

This project is licensed under the BSD 3-Clause Licence. 
See the `LICENSE` file for details.


## Acknowledgments

The `DEPENDENCIES.txt` file has been generated with the [Dependency Manager for MATLAB](https://github.com/CarmVarriale/DependencyManager) by Carmine Varriale.