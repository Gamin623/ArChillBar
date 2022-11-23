package com.AchillBar.base.model.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.AchillBar.base.model.memberModel;

public interface memberDao extends JpaRepository<memberModel, Integer> {

	@Query(value = "from memberModel where email = ?1")
	memberModel findByEmail(String email);

	@Query(value = "from memberModel where phone = ?1")
	public List<memberModel> findByPhone(String phone);

	@Query(value = "from memberModel where email = ?1 and password = ?2")
	public memberModel findByEmailAndPassword(String email,String password);
	
	public List<memberModel> findAll(); 
	
	@Query("From memberModel m where m.admin = 0")
	public Page<memberModel> findAllCustomer(Pageable page);
}
