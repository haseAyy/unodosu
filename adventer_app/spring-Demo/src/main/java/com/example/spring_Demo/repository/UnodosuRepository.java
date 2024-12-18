package com.example.spring_Demo.repository;

//import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;
//import java.util.Optional;



import com.example.spring_Demo.model.UnodosuEntity;

import java.util.List;

@Repository
public interface UnodosuRepository extends JpaRepository <UnodosuEntity,String>{

    //問題をランダムに出題
   /* @Query(value = "SELECT * FROM question WHERE questiontype_id = :questiontype_id " + "AND (:solvedQuestions IS NULL OR :solvedQuestions = '' OR question_id NOT IN (:solvedQuestions)) " + 
                   "ORDER BY RAND() LIMIT 1", nativeQuery = true)
    UnodosuEntity findRandomQuestionExcluding(@Param("questiontype_id") String questiontype_id, @Param("solvedQuestions") List<String> solvedQuestions);*/


    @Query(value = """
    SELECT * FROM question 
    WHERE questiontype_id = :questiontype_id 
    AND (:solvedQuestions IS NULL OR question_id NOT IN (:solvedQuestions)) 
    ORDER BY RAND() LIMIT 1
    """, nativeQuery = true)
    UnodosuEntity findRandomQuestionExcluding(@Param("questiontype_id") String questiontype_id,  @Param("solvedQuestions") List<String> solvedQuestions);

    @Query(value = "SELECT question_answer FROM question WHERE questiontype_id = :questiontype_id " + "AND question_id != :question_id LIMIT 3", nativeQuery = true)
    List<String> findDummyAnswersByType(@Param("question_id") String question_id,  @Param("questiontype_id") String questiontype_id);

}