# Native LangChain4j Searchbot

This is a Java command-line chatbot example application that leverages the [LangChain4j](https://github.com/langchain4j) API and version [_GPT-4_ of OpenAI](https://openai.com/index/gpt-4/). 

> LangChain4j is a Java implementation of [LangChain](https://www.langchain.com/) whose goal is to simplify integrating AI/LLM capabilities into Java applications.

The example is based on a [LangChain4j tutorial](https://github.com/langchain4j/langchain4j-examples/blob/main/open-ai-examples/src/main/java/OpenAiChatModelExamples.java).
This application is enhanced with the [GraalVM Native Image Maven plugin](https://graalvm.github.io/native-build-tools/latest/index.html) that enables you to easily create a native executable from a Java application.

The goal of this example is to demonstrate:
- how easy it is to create a CLI application (that uses LangChain) using ahead-of-time (AOT) compilation
- the use of Profile-Guided Optimization, optimizations for size (`-Os`), SBOM, and other advanced Native Image features

### Prerequisites
* GraalVM JDK (`sdk install java 21.0.2-graal`)
* Maven
* An [OpenAI account](https://platform.openai.com/signup) and an [OpenAI API key](https://platform.openai.com/account/api-keys)

> Note: To interact with OpenAI, store your OpenAI API key as the value of an environment variable named `OPENAI_API_KEY`.

## Package the Application as a Native Executable Using with Maven

1. Clone this repository with Git and then enter it:
    ```bash
    $ git clone https://github.com/olyagpl/langchain4j-searchbot.git
    ```
    ```bash
    $ cd langchain4j-searchbot
    ```

2. Compile and create a JAR file with all dependencies (required for Native Image):
    ```bash
    $ mvn clean package
    ```

3. Create a native executable using the [Maven plugin for Native Image](https://graalvm.github.io/native-build-tools/latest/maven-plugin.html): 
    ```bash
    $ mvn -Pnative package
    ``` 
    This produces a Linux self-contained executable version of the searchbot! 

4. Interact with the searchbot: 
    ```bash
    $ ./target/searchbot “Why should I visit Lviv?”
    ```

## Create an Optimized Native Executable

Create an optimized native executable by taking advantage of some advanced Native Image features such as Profile-Guided Optimization, size optimization (`-Os`, with GraalVM for JDK 23 only), SBOM, and others.

[Profile-Guided Optimization](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/) is a technique that brings profile information to an AOT compiler to improve the quality of its output in terms of performance and size.

1. Build an “instrumented” executable:
    ```bash
    $ native-image \
                -Ob \
                --pgo-instrument \
                -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
                -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
                -o ./target/searchbot-instrumented
    ```

2. Run the executable to gather a profile:
    ```bash
    $ ./target/searchbot-instrumented “What is the weather today?”
    ```
 
3. Build an optimized executable using the profile, then run it: 
    ```bash
    $ native-image \
                -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
                -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
                -Ob \
                --gc=G1 \
                --enable-sbom=cyclonedx \
                -H:-MLProfileInference \
                -march:native \
                --pgo \
                -o ./target/searchbot-optimized
    ```

    ```bash
    $ ./target/searchbot-pgo-optimized “What is JavaDay Lviv?”
    ```
    
    Run `native-image --help` for the explanations of the build options used. 

### Learn More

- [Native Image Command-line Options](https://www.graalvm.org/jdk23/reference-manual/native-image/overview/Options/)
- [Native Image Documentation on Profile-Guided Optimizations](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/)