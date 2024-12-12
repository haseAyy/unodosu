package com.example.spring_Demo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class unodosuEntity{
 
    /*フィールド */
    @Id
    //問題テーブル
    private String question_id;     //問題番号
    private String questiontype_id; //問題種類
    private String question_theme;  //テーマ
    private String question_danger; //危険内容
    private String question_content;//問題内容
    private String question_answer; //正解
    private String question_image;  //画像URL

    //ミッションテーブル
    private String mission_id;
    private String mission_name;
    private String mission_keyword;

    //問題種類テーブル
    private String questiontype_name;

    /*getterとsetterの定義 */

    public String getQuestion_id(){
        return question_id;
    }
    public String getQuestiontype_id(){
        return questiontype_id;
    }
    public String getQuestion_theme(){
        return question_theme;
    }
    public String getQuestion_danger(){
        return question_danger;
    }
    public String getQuestion_content(){
        return question_content;
    }
    public String getQuestion_answer(){
        return question_answer;
    }
    public String getquestion_image(){
        return question_image;
    }
    public String getMission_id(){
        return mission_id;
    }
    public String getMission_name(){
        return mission_name;
    }
    public String getmission_keyword(){
        return mission_keyword;
    }
    public String getQuestiontype_name(){
        return questiontype_name;
    }

    public void setQuestion_id(String question_id){
        this.question_id = question_id;
    }
    public void setQuestiontype_id(String questiontype_id){
        this.questiontype_id = questiontype_id;
    }
    public void setquestion_theme(String question_theme){
        this.question_theme = question_theme;
    }
    public void setQuestion_danger(String question_danger){
        this.question_danger = question_danger;
    }
    public void setQuestion_content(String question_content){
        this.question_content = question_content;
    }
    public void setQuestion_answer(String question_answer){
        this.question_answer = question_answer;
    }
    public void setQuestion_image(String question_image){
        this.question_image = question_image;
    }
    public void setMission_id(String mission_id){
        this.mission_id = mission_id;
    }
    public void setMission_name(String mission_name){
        this.mission_name = mission_name;
    }
    public void setMission_keyword(String mission_keyword){
        this.mission_keyword = mission_keyword;
    }
    public void setQuestiontype_name(String questiontype_name){
        this.questiontype_name = questiontype_name;
    }

}