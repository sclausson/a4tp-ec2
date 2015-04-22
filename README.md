# a4tp-ec2

##Overview
Provides a simple, push-button workflow for deploying the "Automation for the People" website on the AWS EC2 platform.  The infrastrcuture consists of an Elastic Load Balancer (ELB) which 'fronts' web server instance(s).  

Instances are deployed using an Autoscaling Group/Launch Configuration across multiple Availibilty Zones in the US-East-1 region.  In the event that an Instance / Availability Zone is malfunctioning, additional Instances will be launched to 'auto-recover' the site.  Instances and the ELB are protected by Security Groups, which prohibit unauthorized traffic from accessing these resources. All resources are deployed inside a Virtual Private Cloud (VPC), which further limits their exposure from the public internet.

Finally, all infrastrucure is tested using Serverspec.  If any critical components of the website are malfunctioning, then the build will fail.

##Usage
###Automated Builds
This repo is configured with a hook that will automatically trigger a build on my [Jenkins](http://ec2-52-5-248-135.compute-1.amazonaws.com/job/a4tp-multijob/) instance whenever a commit is pushed.  The build creates EC2 infrastructure, runs integration tests, emails results to the committer, and then destroys the infrastructure.  If the commit is tagged, we will assume that this is a release and we will not destroy the infrastructure at the end.  Finally, if the build is unsuccessful (regardless of whether it is tagged) the infrastructure is left in tact for manual inspection.

###Manual Builds
If you want to trigger the build manually just log into my [Jenkins](http://ec2-52-5-248-135.compute-1.amazonaws.com/job/a4tp-multijob/) instance with the credentials given to Antonia and click "Build With Parameters", accepting the defaults.