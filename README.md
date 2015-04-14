# a4tp-ec2

##Overview
Provides a simple, push-button workflow for deploying the "Automation for the People" website on the AWS EC2 platform.  The infrastrcuture consists of an Elastic Load Balancer (ELB) which 'fronts' web server instance(s).  

Instances are deployed using an Autoscaling Group/Launch Configuration across multiple Availibilty Zones in the US-East-1 region.  In the event that an Instance / Availability Zone is malfunctioning, additional Instances will be launched to 'auto-recover' the site.  Instances and the ELB are protected by Security Groups, which prohibit unauthorized traffic from accessing these resources. All resources are deployed inside a Virtual Private Cloud (VPC), which further limits their exposure from the public internet.

Finally, all infrastrucure is tested using Serverspec.  If any critical components of the website are malfunctioning, then the build will fail.

##Usage
Jenkins is used to orchestrate the build.  The Jenkins sever is available [here](http://ec2-52-5-248-135.compute-1.amazonaws.com/).  Login with the username and password provided to Antonia.  Once logged in, navigate to the [a4tp-ec2 job](http://ec2-52-5-248-135.compute-1.amazonaws.com/job/a4tp-ec2/){:target="_blank"} and click "Build with Paramters".  Select your options, and click build. (Please choose t2.micro InstanceType to keep costs down)

The job takes ~5 minutes to complete.  Once complete, the build page will display the URL for the Load Balancer under the Website Information banner.  Click the link, and you will see "Automation for the People".
