package com.example.spring_Demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.spring_Demo.model.unodosuEntity;

import java.util.List;

@Repository
public interface UnodosuRepository extends JpaRepository <unodosuEntity,String>{

    // ランダムで問題を取得（解いた問題を除外）
    @Query(value = "SELECT * FROM question WHERE question_theme = :theme AND question_id NOT IN (:solvedQuestions) ORDER BY RAND() LIMIT 1", nativeQuery = true)
    unodosuEntity findRandomShapeProblemExcluding(String theme, List<String> solvedQuestions);

    // 他の答えをランダムに取得
    @Query(value = "SELECT question_answer FROM question WHERE question_theme = :theme AND question_id != :correctQuestionId ORDER BY RAND()", nativeQuery = true)
    List<String> findOtherAnswers(String correctQuestionId, String theme);
}