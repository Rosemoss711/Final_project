package com.comme.support_board;

import com.comme.utils.PagingVO;
import com.comme.vol.VolBoardDAO;
import com.comme.vol.VolBoardDTO;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SupportBoardService implements SupportBoardDAO {

    @Autowired
    SupportBoardDAO supportBoardDAO;

    @Override
    public List<Map<String, Object>> selectList(@Param("start") int start, @Param("end") int end) throws Exception {
        return supportBoardDAO.selectList(start, end);
    }

    @Override
    public int selectTotalCnt(String category, String search) throws Exception {
        return supportBoardDAO.selectTotalCnt(category, search);
    }

    @Override
    public int insert(SupportBoardDTO supportBoardDTO) throws Exception {
        supportBoardDAO.insert(supportBoardDTO);
        return supportBoardDTO.getSeq_board();
    }

    @Override
    public Map<String, Object> select(int seq_board) throws Exception {
        return supportBoardDAO.select(seq_board);
    }

    @Override
    public int delete(int seq_board) throws Exception {
        return supportBoardDAO.delete(seq_board);
    }

    @Override
    public int update(SupportBoardDTO volBoardDTO) throws Exception {
        return supportBoardDAO.update(volBoardDTO);
    }

    @Override
    public List<Map<String, Object>> search(int start, int end, String category, String search) throws Exception {
        return supportBoardDAO.search(start, end, category, search);
    }

    public Map<String, Object> selectList(int curPage) throws Exception {
        int total = selectTotalCnt(null, null);
        Map<String, Object> map = new HashMap<>();
        PagingVO pagingVO = new PagingVO(total, curPage, 12);
        List<Map<String, Object>> list = selectList(pagingVO.getStart(), pagingVO.getEnd());
        map.put("pagingVO", pagingVO);
        map.put("list", list);

        return map;
    }

    public Map<String, Object> search(int curPage, String category, String search) throws Exception {
        int total = supportBoardDAO.selectTotalCnt(category, search);
        Map<String, Object> map = new HashMap<>();
        PagingVO pagingVO = new PagingVO(total, curPage, 12);
        List<Map<String, Object>> list = search(pagingVO.getStart(), pagingVO.getEnd(), category, search);
        map.put("pagingVO", pagingVO);
        map.put("list", list);

        return map;
    }
}