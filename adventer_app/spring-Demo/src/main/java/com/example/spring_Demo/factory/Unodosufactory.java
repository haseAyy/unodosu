package com.example.spring_Demo.factory;

import com.example.spring_Demo.model.question;
import java.util.List;

public interface Unodosufactory {

    //教育モード
    //question getRandomTextQuestion(String question_theme, List<String> solvedQuestions);

    //お手伝いモード
    question getRandomTextQuestionHelp(String question_theme, List<String> solvedQuestions);
}

   
