package com.example.app;

import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.openai.OpenAiChatModel;

public class SearchBot {

    public static void main(String[] args) {
        if (args.length != 1) {
            throw new IllegalArgumentException("Please provide input for searchbot");
        }
       
        String apiKey = System.getenv("OPENAI_API_KEY");
        if (apiKey == null) {
            throw new IllegalArgumentException("OpenAI API key not found.");
        }

        ChatLanguageModel model = OpenAiChatModel.builder()
            .apiKey(apiKey)
            .modelName("gpt-4")
            .build();

        String answer = model.generate(args[0]);

        System.out.println(answer);
    }
}
