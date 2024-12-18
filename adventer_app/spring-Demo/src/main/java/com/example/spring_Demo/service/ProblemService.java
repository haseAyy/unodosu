package com.example.spring_Demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.spring_Demo.model.UnodosuEntity;
import com.example.spring_Demo.repository.UnodosuRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Collections;

@Service
public class ProblemService {

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

        // 正解選択肢とダミー選択肢を取得
        String correctAnswer = randomQuestion.getQuestion_answer();
        List<String> dummyAnswers = getDummyAnswers(randomQuestion.getQuestion_id(), questiontype_id);

        // 正解とダミーを統合してシャッフル
        List<String> options = new ArrayList<>();
        options.add(correctAnswer);
        options.addAll(dummyAnswers);
        Collections.shuffle(options);

        if (options == null || options.isEmpty()) {
            options = new ArrayList<>();
            options.add("Default Option 1");
            options.add("Default Option 2");
        }
        // 問題オブジェクトに選択肢を設定
        randomQuestion.setOptions(options);

        // ここではoptionsを設定せず、そのまま問題を返す
        return randomQuestion;
        
}

    // 同じquestiontype_idから3つのダミー選択肢を取得
    public List<String> getDummyAnswers(String question_id, String questiontype_id) {

        // ダミー選択肢を同じquestiontype_idから取得する
        List<String> dummyAnswers = unodosuRepository.findDummyAnswersByType(question_id, questiontype_id);

        // 必要なら補完（ダミーが3つ未満の場合、適当なダミーを追加）
        while (dummyAnswers.size() < 3) {
            dummyAnswers.add("Dummy Answer " + (dummyAnswers.size() + 1));
        }

        return dummyAnswers.subList(0, 3); // 3つのダミー選択肢を返す
    }


/*public List<String> getDummyAnswers(String question_id, String questiontype_id) {
    // 3つのダミー選択肢をそのまま返す
    return unodosuRepository.findDummyAnswers(question_id, questiontype_id);
}*/

/*// question_id に基づいて問題を取得
public UnodosuEntity findQuestionById(String question_id) {
return unodosuRepository.findById(question_id)
        .orElseThrow(() -> new IllegalArgumentException("Invalid question ID: " + question_id));
}*/
}
