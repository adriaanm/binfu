#!/usr/bin/env bash
#

# build.sbt:
# scalaVersion := "2.12.1"
# libraryDependencies += "org.scala-lang" % "scala-compiler" % scalaVersion.value
# showSuccess := false
# logLevel in run := Level.Error

java -Dsbt.boot.properties=/Users/adriaan/bin/asmutils-boot.properties -jar /Users/adriaan/git/launcher/target/sbt-launch-1.0.2-SNAPSHOT.jar "$1"
