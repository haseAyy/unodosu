package com.example.spring_Demo.repository;

import org.aspectj.weaver.patterns.TypePatternQuestions.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.query.Param;
import java.util.Optional;



import com.example.spring_Demo.model.UnodosuEntity;

import java.util.List;

@Repository
public interface UnodosuRepository extends JpaRepository <UnodosuEntity,String>{

    


    @Query(value = "SELECT * FROM question WHERE questiontype_id = :questiontype_id " + "AND (:solvedQuestions IS NULL OR :solvedQuestions = '' OR question_id NOT IN (:solvedQuestions)) " + 
                   "ORDER BY RAND() LIMIT 1", nativeQuery = true)
    UnodosuEntity findRandomQuestionExcluding(@Param("questiontype_id") String questiontype_id, @Param("solvedQuestions") List<String> solvedQuestions);

    // 他の答えをランダムに取得
    @Query(value = "SELECT question_answer FROM question WHERE question_theme = :questin_theme " +  
                   "AND question_id != :question_id ORDER BY RAND()", nativeQuery = true)
    List<String> findRandomAnswersExcluding(@Param("question_theme") String theme, @Param("question_id") String question_id);

    @Query(value = "SELECT question_answer FROM question WHERE question_theme = :question_theme " +
                   "AND question_id != :question_id ORDER BY RAND()", nativeQuery = true)
    List<String> findOtherAnswers(@Param("question_theme") String theme, @Param("question_id") String question_id);

    @Query(value = "SELECT question_answer FROM question WHERE question_id != :question_id AND questiontype_id = :questiontype_id LIMIT 3", nativeQuery = true)
    List<String> findDummyAnswers(@Param("question_id") String question_id, @Param("questiontype_id") String questiontype_id);

    /*@Query(value = "SELECT * FROM question " +
               "WHERE questiontype_id = ?1 " +
               "AND (?2 IS NULL OR question_id NOT IN (?3)) " +
               "ORDER BY RAND() LIMIT 1", nativeQuery = true)
Optional<Question> findRandomQuestion(String questiontype_id, List<String> excludedIds);*/


}