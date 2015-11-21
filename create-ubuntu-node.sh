#the purpose of this is to document the minimum packages required to 
#create an ssh accessible ubuntu machine which i can use to run programs 
#on but pull them into my local desktop environment using x forwarding

#minimil ubuntu package
sudo apt-get install aptitude ubuntu-minimal
sudo aptitude markauto '~i!~nubuntu-minimal'

#linux, xorg for x windows system
sudo opt-get xorg openbox linux-image-generic 
