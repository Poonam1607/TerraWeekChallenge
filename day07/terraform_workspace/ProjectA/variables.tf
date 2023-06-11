# variables.tf
variable region {
    default = "us-east-1"
}
variable instance_type {
    default = "t2.micro"
} 
variable ami {
    type = map
    default = {
        "ProjectA" = "ami-0edab43b6fa892279"
        "ProjectB" = "ami-0c2f25c1f66a1ff4d"
    }
}
