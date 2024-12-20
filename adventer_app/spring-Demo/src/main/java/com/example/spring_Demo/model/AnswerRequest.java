package com.example.spring_Demo.model;

public class AnswerRequest {
    private String questionId;
    private String answer;
  
    // GetterとSetterを追加
    public String getQuestionId() {
        return questionId;
    }
  
    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }
  
    public String getAnswer() {
        return answer;
    }
  
    public void setAnswer(String answer) {
        this.answer = answer;
    }
  }