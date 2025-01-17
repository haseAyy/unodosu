package com.example.spring_Demo.controller;

import com.example.spring_Demo.service.MissionService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;


@Controller
public class MissionController {

    @Autowired
    private MissionService missionService;

    // ホームページへのGETリクエストを処理
    @GetMapping("/")
    public String homePage() {
        return "home"; // home.htmlを返してビューを表示
    }

    // ミッションのランダム取得
    @GetMapping("/random")
    public ResponseEntity<Object> getRandomMission() {

        List<String> missionList = missionService.findRandomMission();

        if (missionList != null) {
            return ResponseEntity.ok(missionList); // 200 OKとともにデータを返す
        } else {
            return ResponseEntity.notFound().build(); // データが見つからなかった場合
        }
    }
}
