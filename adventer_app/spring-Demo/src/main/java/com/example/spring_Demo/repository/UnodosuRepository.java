package com.example.spring_Demo.repository;

import com.example.spring_Demo.model.question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;

import java.util.List;

@Repository
public interface UnodosuRepository extends JpaRepository<question, String> {

    @Query(value = """
    SELECT * FROM question 
    WHERE questiontype_id = :questiontype_id 
    AND (:solvedQuestions IS NULL OR question_id NOT IN (:solvedQuestions)) 
    ORDER BY RAND() LIMIT 1
    """, nativeQuery = true)
    question findRandomQuestionExcluding(@Param("questiontype_id") String questiontype_id, @Param("solvedQuestions") List<String> solvedQuestions);

    @Query(value = """
    SELECT question_id, question_answer 
    FROM question 
    WHERE questiontype_id = :questiontype_id 
    AND question_id != :question_id 
    LIMIT 3
    """, nativeQuery = true)
    List<Object[]> findDummyAnswersWithIds(@Param("question_id") String question_id, @Param("questiontype_id") String questiontype_id);

    //お手伝いモード
    @Query(value = """
    SELECT * FROM question 
    WHERE question_theme = :question_theme 
    AND (:solvedQuestions IS NULL OR question_theme NOT IN (:solvedQuestions)) 
    ORDER BY RAND() LIMIT 1
    """, nativeQuery = true)
    question findRandomQuestionExcludingHelp(@Param("question_theme") String questiontype_id, @Param("solvedQuestions") List<String> solvedQuestions);

    @Query(value = """
    SELECT question_id, question_answer 
    FROM question 
    WHERE question_theme = :question_theme 
    AND question_id != :question_id 
    LIMIT 3
    """, nativeQuery = true)
    List<Object[]> findDummyAnswersWithIdsHelp(@Param("question_id") String question_id, @Param("question_theme") String question_theme);

}
