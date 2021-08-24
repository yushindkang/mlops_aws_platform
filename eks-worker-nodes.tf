#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "mlops-node" {
  name = "terraform-eks-mlops-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "mlops-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.mlops-node.name
}

resource "aws_iam_role_policy_attachment" "mlops-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.mlops-node.name
}

resource "aws_iam_role_policy_attachment" "mlops-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.mlops-node.name
}

resource "aws_eks_node_group" "mlops" {
  cluster_name    = aws_eks_cluster.mlops.name
  node_group_name = "mlops"
  node_role_arn   = aws_iam_role.mlops-node.arn
  subnet_ids      = aws_subnet.mlops[*].id

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.mlops-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.mlops-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.mlops-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
