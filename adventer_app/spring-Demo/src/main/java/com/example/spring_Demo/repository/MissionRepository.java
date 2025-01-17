package com.example.spring_Demo.repository;

import com.example.spring_Demo.model.Mission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MissionRepository extends JpaRepository<Mission, String> {

    // ランダムにミッションを1つ取得（Missionエンティティを返す）
    @Query(value = """
        SELECT *
        FROM mission
        ORDER BY RAND()
        LIMIT 1
        """, nativeQuery = true)
    Optional<Mission> findRandomMission();  // 返り値の型をMissionに変更
}
