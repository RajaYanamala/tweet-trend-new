FROM tomcat:8

ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar TeamProject.jar

ENTRYPOINT ["java","-jar", "TeamProject.jar"]