package com.AchillBar.base.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.AchillBar.base.model.Comment;
import com.AchillBar.base.model.dao.CommentDao;
@Transactional
@Service
public class CommentService {

    @Autowired
    CommentDao cDao;

    public Double getAvgScoreByPid(Integer id){

        return cDao.getAvgScoreByPid(id);


    }
    public Comment insert(Comment msg) {
        return cDao.save(msg);
    }
    
    public Comment  findById(Long id) {
        Optional<Comment> optional = cDao.findById(id);
        
        if(optional.isPresent()) {
            return optional.get();
        }
        
        return null;
    }
    
    public void deleteById(Long com_id) {
        cDao.deleteById(com_id);
        
    }
    public List<Comment> findAll() {
        return cDao.findAll();
    }


}
