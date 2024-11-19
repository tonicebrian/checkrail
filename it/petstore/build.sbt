import Dependencies._

Global / onChangedBuildSource := ReloadOnSourceChanges

ThisBuild / scalaVersion := "2.13.12"
ThisBuild / version := "0.1.0-SNAPSHOT"
ThisBuild / organization := "com.example"
ThisBuild / organizationName := "example"

lazy val root = (project in file("."))
  .settings(
    name := "petstore",
    libraryDependencies ++= {
      val http4sV = "0.23.16"
      val circeV = "0.14.6"
      val logbackClassicV = "1.4.4"
      val munitCatsEffectV = "1.0.7"

      Seq(
        munit % Test,
        "org.http4s" %% "http4s-dsl" % http4sV,
        "org.http4s" %% "http4s-ember-server" % http4sV,
        "org.http4s" %% "http4s-ember-client" % http4sV,
        "org.http4s" %% "http4s-circe" % http4sV,

        "io.circe" %% "circe-core" % circeV,
        "io.circe" %% "circe-generic" % circeV,
        "io.circe" %% "circe-parser" % circeV,

        "ch.qos.logback" % "logback-classic" % logbackClassicV,

        "org.typelevel" %% "munit-cats-effect-3" % munitCatsEffectV % Test,
      )
    }
  )
Compile / guardrailTasks := List(
  ScalaClient(file("src/main/openapi/petstore.yaml"), pkg = "com.petstore", framework="http4s"),
  //  ScalaServer(file("src/main/openapi/petstore.yaml"), pkg = "com.petstore", tracing = true, framework="http4s"),
  ScalaModels(file("src/main/openapi/petstore.yaml"), pkg = "com.petstore", framework="http4s")
)