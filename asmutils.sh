#!/usr/bin/env bash
#

# build.sbt:
# scalaVersion := "2.12.1"
# libraryDependencies += "org.scala-lang" % "scala-compiler" % scalaVersion.value
# showSuccess := false
# logLevel in run := Level.Error

java -Dsbt.boot.properties=/Users/adriaan/bin/asmutils-boot.properties -jar /usr/local/Cellar/sbt/1.1.4/libexec/bin/sbt-launch.jar "$1"
