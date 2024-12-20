package com.example.spring_Demo.service;

import com.example.spring_Demo.model.question;
import com.example.spring_Demo.repository.UnodosuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ProblemService {

    @Autowired
    private UnodosuRepository unodosuRepository;

    public question getRandomTextQuestion(String questiontype_id, List<String> solvedQuestions) {
        solvedQuestions = Optional.ofNullable(solvedQuestions).orElse(new ArrayList<>());

        question randomQuestion = unodosuRepository.findRandomQuestionExcluding(questiontype_id, solvedQuestions);
        if (randomQuestion == null) {
            return null;
        }

        String correctAnswer = randomQuestion.getQuestion_answer();
        String correctQuestionId = randomQuestion.getQuestion_id();

        List<Object[]> dummyData = unodosuRepository.findDummyAnswersWithIds(correctQuestionId, questiontype_id);

        Map<String, String> options = new HashMap<>();
        options.put(correctAnswer, correctQuestionId);

        for (Object[] data : dummyData) {
            String dummyAnswer = (String) data[1];
            String dummyQuestionId = (String) data[0];
            options.put(dummyAnswer, dummyQuestionId);
        }

        List<Map.Entry<String, String>> entryList = new ArrayList<>(options.entrySet());
        Collections.shuffle(entryList);

        Map<String, String> shuffledOptions = new LinkedHashMap<>();
        for (Map.Entry<String, String> entry : entryList) {
            shuffledOptions.put(entry.getKey(), entry.getValue());
        }

        randomQuestion.setOptions(shuffledOptions);
        return randomQuestion;
    }

    public boolean checkAnswer(String questionId, String selectedAnswer) {
        return unodosuRepository.findById(questionId)
                .map(question -> question.getQuestion_answer().equals(selectedAnswer))
                .orElse(false);
    }
}
