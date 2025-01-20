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
    
        // 解いていないランダムな問題を取得する
        public question getRandomTextQuestionHelp(String question_theme, List<String> solvedQuestions) {
    
            // solvedQuestionsがnullの場合は新しいリストを作成
            solvedQuestions = Optional.ofNullable(solvedQuestions).orElse(new ArrayList<>());
    
            // リポジトリから解いていない問題をランダムに取得
            question randomQuestion = unodosuRepository.findRandomQuestionExcludingHelp(question_theme, solvedQuestions);
            if (randomQuestion == null) {
                return null; // 未解答の問題が存在しない場合はnullを返す
            }
    
            // 正解の回答と問題ID、危険な内容を取得
            String correctAnswer = randomQuestion.getQuestion_answer();
            String correctQuestionId = randomQuestion.getQuestion_id();
            String dangerContent = randomQuestion.getQuestion_danger();
    
            // ダミーの回答をリポジトリから取得
            List<Object[]> dummyData = unodosuRepository.findDummyAnswersWithIdsHelp(correctQuestionId, question_theme);
    
            // ダミー回答をリストに変換（正解と危険内容を除外）
            List<String> dummyAnswers = new ArrayList<>();
            for (Object[] data : dummyData) {
                String dummyAnswer = (String) data[1];
                if (!dummyAnswer.equals(correctAnswer) && !dummyAnswer.equals(dangerContent)) {
                    dummyAnswers.add(dummyAnswer);
                }
            }
    
            // ダミー回答をランダムにシャッフル
            Collections.shuffle(dummyAnswers);
    
            // 選択肢を作成（正解 + 危険内容 + ダミーから2つ）
            List<String> options = new ArrayList<>();
            options.add(correctAnswer); // 正解
            options.add(dangerContent); // 危険内容
            options.addAll(dummyAnswers.subList(0, Math.min(2, dummyAnswers.size()))); // ダミーから最大2つ
    
            // 選択肢をシャッフル
            Collections.shuffle(options);
    
            // シャッフルされた選択肢をマップに格納
            Map<String, String> shuffledOptions = new LinkedHashMap<>();
            for (String option : options) {
                if (option.equals(correctAnswer)) {
                    shuffledOptions.put(option, correctQuestionId);
                } else if (option.equals(dangerContent)) {
                    shuffledOptions.put(option, "danger-content");
                } else {
                    shuffledOptions.put(option, "dummy-content");
                }
            }
    
            // 問題オブジェクトに選択肢をセット
            randomQuestion.setOptions(shuffledOptions);
            return randomQuestion; // 問題を返却
        }
    }
