package com.example.spring_Demo.controller;

import com.example.spring_Demo.service.MissionService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class MissionController {

    private static final DateTimeFormatter dtf3 = DateTimeFormatter.ofPattern("yyyyMMddHHmm");

    private LocalDateTime lastFetchedTime = null; // 最後にミッションを取得した時刻
    
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
        
        LocalDateTime nowDate = LocalDateTime.now();
        String formatNowDate = dtf3.format(nowDate);
        long now = Long.parseLong(formatNowDate);

        // lastFetchedTimeがnullもしくは前回の取得時刻が現在時刻よりも古い場合に新しいミッションを取得
        if (lastFetchedTime == null || now > Long.parseLong(dtf3.format(lastFetchedTime))) {
            List<String> missionList = missionService.findRandomMission();
            lastFetchedTime = nowDate; // ミッション取得後、最後に取得した時刻を更新

            if (!missionList.isEmpty()) {
                return ResponseEntity.ok(missionList); // 200 OKとともにデータを返す
            } else {
                return ResponseEntity.notFound().build(); // データが見つからなかった場合
            }
        } else {
            // すでにミッションが取得されている場合、キャッシュした結果を返す
            return ResponseEntity.ok("ミッションはすでに取得されています");
        }
    }
}
