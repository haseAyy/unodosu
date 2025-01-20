package com.example.spring_Demo.factory;

import com.example.spring_Demo.model.question;
import java.util.List;

public interface Unodosufactory {

    //お手伝いモード（お片付け編)
    question getRandomTextQuestionHelp(String question_theme, List<String> solvedQuestions);
}

   
