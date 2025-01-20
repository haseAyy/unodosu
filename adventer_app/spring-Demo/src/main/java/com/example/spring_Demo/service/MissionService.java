package com.example.spring_Demo.service;

import com.example.spring_Demo.repository.MissionRepository;
import com.example.spring_Demo.model.Mission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.List;
import java.util.ArrayList;

@Service
public class MissionService {

    @Autowired
    private MissionRepository missionRepository;

    // ランダムなミッションを取得するメソッド
    public List<String> findRandomMission() {
        // ランダムなミッションを取得
        Optional<Mission> mission = missionRepository.findRandomMission();

        if (mission.isPresent()) {
            Mission missionData = mission.get();

            // ミッション情報をMissionResponseに変換してリストに追加
            List<String> missionList = new ArrayList<>();
            missionList.add(missionData.getMissionId());
            missionList.add(missionData.getMissionName());
            missionList.add(missionData.getMissionKeyword());
            return missionList;
        }
        return new ArrayList<>(); // ミッションが存在しない場合、空のリストを返す
    }

    // ミッション情報を保持するレスポンスクラス
    public static class MissionResponse {
        private String missionId;
        private String missionName;
        private String missionKeyword;

        public MissionResponse(String missionId, String missionName, String missionKeyword) {
            this.missionId = missionId;
            this.missionName = missionName;
            this.missionKeyword = missionKeyword;
        }

        // Getters and Setters
        public String getMissionId() {
            return missionId;
        }

        public void setMissionId(String missionId) {
            this.missionId = missionId;
        }

        public String getMissionName() {
            return missionName;
        }

        public void setMissionName(String missionName) {
            this.missionName = missionName;
        }

        public String getMissionKeyword() {
            return missionKeyword;
        }

        public void setMissionKeyword(String missionKeyword) {
            this.missionKeyword = missionKeyword;
        }
    }
}
