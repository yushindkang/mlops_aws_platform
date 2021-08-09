variable "region" {
    default = "ap-southeast-2"
    description = "AWS region"
}

variable "cluster_name" {
    default = "getting-started-eks"
}

var "map_accounts" {
    description = "Additional aws account numbers to add to the aws-auth config map."
    type = list(string)

    default = [
        "777777777",
        "888888888",
    ]
}

var "map_roles" {
    description = "Additional IAM roles to add to the aws-auth configmap."
    type = list(object({
        rolearn = string
        username = string
        groups = list(string)
    }))

    default = [
        {
            rolearn = "arn:aws:iam::666666666:role/role1"
            username = "role1"
            groups = ["system:masters"]
        },
    ]
}

variable "map_users" {
    description = "Additional IAM users to add to the aws-auth configmap."
    type = list(object({
        userarn  = string
        username = string
        groups   = list(string)
    }))

    default = [
        {
            userarn  = "arn:aws:iam::66666666666:user/user1"
            username = "user1"
            groups   = ["system:masters"]
        },
        {
            userarn  = "arn:aws:iam::66666666666:user/user2"
            username = "user2"
            groups   = ["system:masters"]
        },
    ]
}