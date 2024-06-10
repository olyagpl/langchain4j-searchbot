# Native LangChain4j Searchbot

This is a Java command-line chatbot example application that leverages the [LangChain4j](https://github.com/langchain4j) API and version [_GPT-4_ of OpenAI](https://openai.com/index/gpt-4/). 

> LangChain4j is a Java implementation of [LangChain](https://www.langchain.com/) whose goal is to simplify integrating AI/LLM capabilities into Java applications.

The example is based on a [LangChain4j tutorial](https://github.com/langchain4j/langchain4j-examples/blob/main/open-ai-examples/src/main/java/OpenAiChatModelExamples.java).
This application is enhanced with the [GraalVM Native Image Maven plugin](https://graalvm.github.io/native-build-tools/latest/index.html) that enables you to easily create a native executable from a Java application.

The goal of this example is to demonstrate:
- how easy it is to create a CLI application (that uses LangChain) using ahead-of-time (AOT) compilation
- how to optimize a native executable for file size

### Prerequisites

* [GraalVM for JDK 23 Early Access build](https://github.com/graalvm/oracle-graalvm-ea-builds/releases)
* An [OpenAI account](https://platform.openai.com/signup) and an [OpenAI API key](https://platform.openai.com/account/api-keys)
* Maven

> Note: To interact with OpenAI, store your OpenAI API key as the value of an environment variable named `OPENAI_API_KEY`.

## Package the Application as a Native Executable with Maven

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

## Create a Native Executable Optimized for File Size

You can optimize your native executable by taking advantage of different optimization levels.
The following levels are available:
```bash
# native-image --help output
    -O                    control code optimizations: b - optimize for fastest build time, s
                          - optimize for size, 0 - no optimizations, 1 - basic
                          optimizations, 2 - advanced optimizations, 3 - all optimizations
                          for best performance.
```

For this application, use the `-Os` option to create the smallest possible native executable.

1. Create a native executable with the file size optimization on, and giving it a different name:
    ```bash
    $ native-image \
        -Os \
        -jar ./target/searchbot-1.0-jar-with-dependencies.jar \
        -H:+AllowDeprecatedBuilderClassesOnImageClasspath \
        -o ./target/searchbot-optimized
    ```

2. Interact with the searchbot to test it: 
    ```bash
    $ ./target/searchbot-optimized “What is JavaDay Lviv?”
    ```

3. Compare the sizes of all relevant output files:
    ```bash
    $ du -h target/searchbot*
    ```

    You should see the output similar to this:
    ```
    35M	target/searchbot
    208M	target/searchbot-1.0-jar-with-dependencies.jar
    8.0K	target/searchbot-1.0.jar
    31M	target/searchbot-optimized
    ```

There are other Native Image techniques that can improve your application performance and positively affect the executable size, for example [Profile-Guided Optimizations (PGO)](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/PGO/). 
The improvement degree depends on the application complexity. 
Find more in the [Native Image Optimizations and Performance documentation](https://www.graalvm.org/jdk23/reference-manual/native-image/optimizations-and-performance/#optimization-levels).

### Learn More

- [Native Image Command-line Options](https://www.graalvm.org/jdk23/reference-manual/native-image/overview/Options/)
- [Native Image Optimizations and Performance](https://www.graalvm.org/jdk23/reference-manual/native-image/optimizations-and-performance/#optimization-levels)
- [Native Image Build Tools](https://graalvm.github.io/native-build-tools/latest/index.html)