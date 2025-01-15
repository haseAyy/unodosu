package com.example.spring_Demo.service;

import com.example.spring_Demo.factory.Unodosufactory;
import com.example.spring_Demo.model.question;
import com.example.spring_Demo.repository.UnodosuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class HelpProblemService implements Unodosufactory{

    @Autowired
    private UnodosuRepository unodosuRepository;

    // ランダムな問題を取得する
    public question getRandomTextQuestionHelp(String question_theme, List<String> solvedQuestions) {
        
                // solvedQuestionsがnullの場合は新しいリストを作成
                solvedQuestions = Optional.ofNullable(solvedQuestions).orElse(new ArrayList<>());

                // リポジトリからランダムな問題を取得 (解いた問題を除外)
                question randomQuestion = unodosuRepository.findRandomQuestionExcludingHelp(question_theme, solvedQuestions);
                if (randomQuestion == null) {
                    return null;  // 問題が存在しない場合はnullを返す
                }
        
                // 正解の回答と問題IDを取得
                String correctAnswer = randomQuestion.getQuestion_answer();
                String correctQuestionId = randomQuestion.getQuestion_id();
        
                // ダミーの回答をリポジトリから取得
                List<Object[]> dummyData = unodosuRepository.findDummyAnswersWithIdsHelp(correctQuestionId, question_theme);
        
                // 選択肢を格納するマップを作成し、正解を追加
                Map<String, String> options = new HashMap<>();
                options.put(correctAnswer, correctQuestionId);
        
                // ダミーデータをループ処理し、選択肢としてマップに追加
                for (Object[] data : dummyData) {
                    String dummyAnswer = (String) data[1];
                    String dummyQuestionId = (String) data[0];
                    options.put(dummyAnswer, dummyQuestionId);
                }
        
                // 選択肢をシャッフルして順序をランダム化
                List<Map.Entry<String, String>> entryList = new ArrayList<>(options.entrySet());
                Collections.shuffle(entryList);
        
                // シャッフルされた選択肢を再度マップに格納
                Map<String, String> shuffledOptions = new LinkedHashMap<>();
                for (Map.Entry<String, String> entry : entryList) {
                    shuffledOptions.put(entry.getKey(), entry.getValue());
                }

                // 問題オブジェクトに選択肢をセット
                //randomQuestion.setOptions(shuffledOptions);
                //return randomQuestion;  // 問題を返却

                // 問題オブジェクトに選択肢をセット画像URLを返す
                randomQuestion.setOptions(shuffledOptions);
                return randomQuestion;
            }

            
        
            // 回答を検証するメソッド
            public boolean checkAnswer(String questionId, String selectedAnswer) {
                return unodosuRepository.findById(questionId)
                        .map(question -> question.getQuestion_answer().equals(selectedAnswer))
                        .orElse(false);  // 該当の問題が存在しない場合はfalseを返す
            }
    
}

    
