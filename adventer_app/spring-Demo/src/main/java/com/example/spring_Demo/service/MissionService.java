package com.example.spring_Demo.service;

import com.example.spring_Demo.repository.MissionRepository;
import com.example.spring_Demo.model.Mission;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.ArrayList;
import java.util.List;

@Service
public class MissionService {

    @Autowired
    private MissionRepository missionRepository;

    public List<String> findRandomMission() {
        // ランダムなミッションを取得
        Optional<Mission> mission = missionRepository.findRandomMission();

        if (mission.isPresent()) {
            Mission missionData = mission.get();

            List<String> missionList = new ArrayList<>();
            missionList.add(missionData.getMissionId()); 
            missionList.add(missionData.getMissionName());
            missionList.add(missionData.getMissionKeyword());
            // Listを返却
            return missionList;
        }
        return null; // ミッションが存在しない場合
    }

    // ミッション取得に使うレスポンス用のクラス
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
