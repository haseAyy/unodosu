package com.example.spring_Demo.service;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.spring_Demo.model.unodosuEntity;
import com.example.spring_Demo.repository.UnodosuRepository;

import java.util.List;


@Service
public class ProblemService {

    //private final UnodosuRepository unodosrepository;
    @Autowired

    private UnodosuRepository unodosuRepository;

    // 解いた問題を除外してランダムな問題を取得
    public unodosuEntity getRandomTextQuestion(String theme, List<String> solvedQuestions) {
        return unodosuRepository.findRandomShapeProblemExcluding(theme, solvedQuestions);
    }

    // 選択肢を生成（正解 + ランダムな3つの他の答え）
    public List<String> getAnswerOptions(String correctQuestionId, String theme) {
        List<String> otherAnswers = unodosuRepository.findOtherAnswers(correctQuestionId, theme);
        return otherAnswers.stream()
                .limit(3) // ランダムに3つ取得
                .collect(Collectors.toList());
    }
}
