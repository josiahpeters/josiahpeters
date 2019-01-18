+++
title = "Setting up an HTTPS static hosted website in AWS with Terraform"
description = "Here are the steps I went through to create an HTTPS static hosted website in AWS using: Route53 for DNS, S3 to host the website, AWS Certificate Manager for SSL, CloudFront as my CDN to serve HTTPS traffic all with Terraform."
date = 2018-09-17T12:35:03-06:00
weight = 20
draft = false
+++

# What is the purpose of this post?

Recently at my job [Konexus](https://www.konexus.com), I foolishly went through the manual process of setting up a static hosted website in AWS. The requirements for this website were as follows:

- Host a static website generated from [Hugo](https://gohugo.io/) in an AWS S3 Bucket.
- Only serve HTTPS requests from the S3 bucket. This required using AWS CloudFront in front of the bucket.
- Redirect non-https traffic with `301 Moved Permanently` to https

# What is Terraform?

Directly from the [Terraform intro page](https://www.terraform.io/intro/index.html):
> Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.
>
> Configuration files describe to Terraform the components needed to run a single application or your entire datacenter. Terraform generates an execution plan describing what it will do to reach the desired state, and then executes it to build the described infrastructure. As the configuration changes, Terraform is able to determine what changed and create incremental execution plans which can be applied.
>
>The infrastructure Terraform can manage includes low-level components such as compute instances, storage, and networking, as well as high-level components such as DNS entries, SaaS features, etc.

What in the world does that mean? Terraform is a command line tool that you can run against configuration files you create to create infrastructure. For this blog post, I am going to show you how Terraform will take configuration files and create all of the necessary resources and infrastructure in AWS to host a static website.