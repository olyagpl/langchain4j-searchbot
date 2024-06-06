# Native LangChain4j Searchbot

This is a Java command-line chatbot application that leverages [LangChain4j](https://github.com/langchain4j/langchain4j) and the OPENAI API model "gpt-4". 

> [LangChain4j](https://github.com/langchain4j/langchain4j) is a Java version of LangChain to simplify integrating AI/LLM capabilities into Java applications.

The example is based on a [LangChain4j tutorial](:https://github.com/langchain4j/langchain4j-examples).
This application is enhanced with [GraalVM Native Image Maven plugin](https://graalvm.github.io/native-build-tools/latest/index.html) that enables you to easily create a native executable for a Java application.

The goal of this project is to demonstrate:
- how easy it is to ahead-of-time compile a CLI application that uses the LLM
- the use of Profile-guided optimizations and SBOM Native Image features

### Prerequisites
* GraalVM JDK (`sdk install java 21.0.2-graal`)
* Maven
* OPENAI API key 

NOTE: To interact with the OpenAI API, you need to either get and store an OPENAI API key in an environment variable `OPENAI_API_KEY`.

## Package the Aplication into a Native Executable Using with Maven

1. Clone this repository with Git and then enter it:
    ```bash
    git clone https://github.com/olyagpl/langchain4j-searchbot.git
    ```
    ```bash
    cd langchain4j-searchbot
    ```

2. Compile and create a JAR file with all dependencies (required for Native Image):
    ```bash
    $ mvn clean package
    ```

3. Create a native executable using the [Maven plugin for Native Image](https://graalvm.github.io/native-build-tools/latest/maven-plugin.html): 
    ```bash
    $ mvn -Pnative package
    ``` 
    This produces a Linux self-contained executable version of the seachbot! 

4. Interact with the seachbot: 
    ```bash
    $ ./target/searchbot “Why should I visit Lviv?”
    ```

## Apply Profile-Guided Optimizations to Create an Optimized Native Executable

[Profile-Guided Optimizations](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/) is the technique fetching the profiling information to the AOT compiler to improve the performance and file size of a native executable.

1. Build an “instrumented” executable and run it to gather profiles:
    ```bash
    $ native-image -jar ./target/searchbot-1.0-jar-with-dependencies.jar --pgo-instrument -o ./target/searchbot-instrumented
    ```
    ```bash
    $ ./target/searchbot-instrumented “What is the weather today?”
    ```
 
2. Build a PGO-optimized executable that will pick up the  gathered profiles, and  run: 
    ```bash
    $ native-image -jar ./target/searchbot-1.0-jar-with-dependencies.jar --pgo -o ./target/searchbot-pgo-optimized
    ```
    ```bash
    $ ./target/searchbot-pgo-optimized “What is JavaDay Lviv”
    ```

### Learn More

- [Native Image Documentation on Profile-Guided Optimizations](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/)