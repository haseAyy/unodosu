package com.example.spring_Demo.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "mission")
public class Mission {
    @Id
    private String missionId;

    private String missionName;

    private String missionKeyword;

    // GetterとSetter
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

