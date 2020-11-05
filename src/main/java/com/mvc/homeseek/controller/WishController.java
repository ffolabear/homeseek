package com.mvc.homeseek.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mvc.homeseek.model.biz.WishBiz;
import com.mvc.homeseek.model.dto.RoomDto;
import com.mvc.homeseek.model.dto.WishDto;

@Controller
public class WishController {
	
	private Logger logger = LoggerFactory.getLogger(WishController.class);
	
	@Autowired
	private WishBiz wishbiz;
	
	@RequestMapping(value="wish.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, String> insert_deleteWish(@RequestBody WishDto dto, RedirectAttributes msg){
		
		Map<String, String> result = new HashMap<String, String>();
		
		int select = wishbiz.selectWishCheck(dto);
		
		
		// 이미 wishlist에 있다면
		if(select > 0) {
			int delete = wishbiz.deleteWish(dto);
			result.put("deletewish", "delete");
			return result;
		} else {
			int insert = wishbiz.insertWish(dto);
			result.put("insertwish", "insert");
			return result;
		}
		
	}
	
	@RequestMapping("mypagewishlist.do")
	public String mypageWishList(String wish_id, Model model) {
		logger.info("[ WishController ] mypageWishList");
		
		List<WishDto> wishlist = null;
		
		wishlist = wishbiz.selectWishList(wish_id);
		
		model.addAttribute("wishlist", wishlist);
		
		return "mypageMywish";
	}

}
