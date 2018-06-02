FROM java:openjdk-8-jdk
MAINTAINER Aimswebcraft001

#Add Mule runtime in Docker Container
CMD echo "------ Add Mule runtime in Docker Container --------"
ADD  mule-ee-distribution-standalone-3.9.1.zip /Mule

#Add Work Directory
CMD echo "------ Adding Work Directory --------"
WORKDIR /Mule

#Unzip the runtime distro
CMD echo "------ Unzipping the distro --------"
RUN         unzip mule-ee-distribution-standalone-3.9.1.zip && \
            rm mule-ee-distribution-standalone-3.9.1.zip

# Define volumes
VOLUME      ["/Mule/mule-enterprise-standalone-3.8.5/logs", "/Mule/mule-enterprise-standalone-3.8.5/apps", "/Mule/mule-enterprise-standalone-3.8.5/domains"]

# Copy and install license
CMD echo "------ Copy and install license --------"
COPY        mule-ee-license.lic mule-enterprise-standalone-3.9.1/conf/
RUN         mule-enterprise-standalone-3.9.1/bin/mule -installLicense mule-enterprise-standalone-3.9.1/conf/mule-ee-license.lic

#Check if Mule Licence is installed
RUN ls -ltr mule-enterprise-standalone-3.9.1/conf/
CMD echo "------ Licence installed ! --------"

#Copy and deploy mule application in runtime
CMD echo "------ Deploying mule application in runtime ! --------"
COPY  helloworld-1.0-SNAPSHOT.zip mule-enterprise-standalone-3.9.1/apps/
RUN ls -ltr mule-enterprise-standalone-3.9.1/apps/
# HTTP Service Port
# Expose the necessary port ranges as required by the Mule Apps
EXPOSE      8081-8082
EXPOSE      9000
EXPOSE      9082
# Mule remote debugger
EXPOSE      5000
# Mule JMX port (must match Mule config file)
EXPOSE      1098
# Mule MMC agent port
EXPOSE      7777
# AMC agent port
EXPOSE      9997
# Start Mule runtime
CMD echo "------ Start Mule runtime --------"
CMD         ["mule-enterprise-standalone-3.9.1/bin/mule"]
