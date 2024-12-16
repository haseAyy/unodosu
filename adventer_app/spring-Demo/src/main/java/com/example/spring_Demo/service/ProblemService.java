package com.example.spring_Demo.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.spring_Demo.model.UnodosuEntity;
import com.example.spring_Demo.repository.UnodosuRepository;

import java.util.ArrayList;
import java.util.List;


@Service
public class ProblemService {

    //private final UnodosuRepository unodosrepository;
    @Autowired

    private UnodosuRepository unodosuRepository;


    public UnodosuEntity getRandomTextQuestion(String questiontype_id, List<String> solvedQuestions) {

        // 空リストの場合でもnullではなく空リストを渡す
        if (solvedQuestions == null) {
            solvedQuestions = new ArrayList<>();
        }

 // ランダムな問題を取得
 UnodosuEntity randomQuestion = unodosuRepository.findRandomQuestionExcluding(questiontype_id, solvedQuestions);

 if (randomQuestion == null) {
     return null; // 問題が見つからない場合はnullを返す
 }

 // ここではoptionsを設定せず、そのまま問題を返す
 return randomQuestion;
        
}

/*public List<String> getAnswerOptions(String correctQuestion_id, String question_theme) {
List<String> otherAnswers = unodosuRepository.findOtherAnswers(correctQuestion_id, question_theme);
return otherAnswers;  // ランダムに3つ取得されるため、limitは不要
}


public List<String> getDummyAnswers(String question_id, String questiontype_id) {
// 3つのダミー選択肢をそのまま返す
return unodosuRepository.findDummyAnswers(question_id, questiontype_id);
}

// question_id に基づいて問題を取得
public UnodosuEntity findQuestionById(String question_id) {
return unodosuRepository.findById(question_id)
        .orElseThrow(() -> new IllegalArgumentException("Invalid question ID: " + question_id));
}*/
}
