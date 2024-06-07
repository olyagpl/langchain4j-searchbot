# Native LangChain4j Searchbot

This is a Java command-line chatbot example application that leverages the [LangChain4j](https://github.com/langchain4j) API and version [_GPT-4_ of OpenAI](https://openai.com/index/gpt-4/). 

> LangChain4j is a Java implementation of [LangChain](https://www.langchain.com/) whose goal is to simplify integrating AI/LLM capabilities into Java applications.

The example is based on a [LangChain4j tutorial](https://github.com/langchain4j/langchain4j-examples).
<!-- Which one? -->
This application is enhanced with the [GraalVM Native Image Maven plugin](https://graalvm.github.io/native-build-tools/latest/index.html) that enables you to easily create a native executable from a Java application.

The goal of this example is to demonstrate:
- how easy it is to create a CLI application (that uses LangChain) using ahead-of-time (AOT) compilation
- the use of Profile-guided optimizations and SBOM Native Image features

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

    <!-- Does it? Surely it depends on the platform? -->

4. Interact with the searchbot: 
    ```bash
    $ ./target/searchbot “Why should I visit Lviv?”
    ```

## Apply Profile-Guided Optimization to Create an Optimized Native Executable

[Profile-Guided Optimization](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/) is a technique that brings profile information to an AOT compiler to improve the quality of its output in terms of performance and size.

1. Build an “instrumented” executable:
    ```bash
    $ native-image 
          -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
          --pgo-instrument \
          -o ./target/searchbot-instrumented
    ```

2. Run the executable to gather a profile:
    ```bash
    $ ./target/searchbot-instrumented “What is the weather today?”
    ```
 
3. Build a PGO-optimized executable using the profile, then run it: 
    ```bash
    $ native-image \
          -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
          --pgo \
          -o ./target/searchbot-pgo-optimized
    ```
    ```bash
    $ ./target/searchbot-pgo-optimized “What is JavaDay Lviv?”
    ```

### Learn More

- [Native Image Documentation on Profile-Guided Optimizations](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/)