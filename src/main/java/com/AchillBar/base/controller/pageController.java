package com.AchillBar.base.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.AchillBar.base.model.Booking;
import com.AchillBar.base.model.Orderdetails;
import com.AchillBar.base.model.dao.BookingDao;
import com.AchillBar.base.model.dao.OrderDao;
import com.AchillBar.base.model.dao.OrderDetailDao;
import com.AchillBar.base.model.dao.ProductDao;

@Controller
public class pageController {

	@Autowired
	OrderDetailDao odDao;

	@Autowired
	OrderDao oDao;


	@Autowired
	BookingDao bDao;
	@Autowired
	ProductDao pDao;

	@GetMapping("/")
	public String homePage() {
		return "index.jsp";
	}

	@GetMapping("/menu")
	public String menuPage() {
		return "menu/menu.html";
	}

	@GetMapping("/menu/adds")
	public String addMutiPro() {
		return "dep/addMenu.html";
	}

	@GetMapping("/booking")
	public String bookingPage() {
		return "member/booking.html";
	}

	@GetMapping("/bak/comm")
	public String comm() {
		return "WMS/comment.html";
	}

	@GetMapping("/myOrder")
	public String myOrder() {
		return "member/orderRecord.html";
	}

	@GetMapping("/bak/pro")
	public String bakPro() {
		return "WMS/product_backed.html";
	}

	@GetMapping("/bak/member")
	public String bakmember() {
		return "WMS/member_backed.html";
	}

	@GetMapping("/bak/ordertest")
	public String ordertest() {
		return "WMS/ordertest.html";
	}

	@GetMapping("/bak/manger")
	public String dlp01() {
		return "WMS/Manger.html";
	}

	@GetMapping("/bak/pastorder")
	public String pastorder() {
		return "WMS/pastorder.html";
	}

	@GetMapping("/bak/bookingbacked")
	public String bookingbacked() {
		return "WMS/bookingbacked.html";
	}

	@GetMapping("/findOdDteails/{id}")
	public String OdDteails(@PathVariable Long id, Model model) {
		// 依靠orderId找訂單的明細
		List<Booking> bookList = bDao.findByb_id(oDao.findById(id).get().getB_id());
		Booking book = bookList.get(0);
		model.addAttribute("b_status", book.getStatus());
		System.out.println(book.getStatus());

		List<Orderdetails> result = odDao.findDetailByOrderId(id);
		model.addAttribute("detail", result);
		List<Map<String, Object>> presult = pDao.findDetailsproduct();
		model.addAttribute("product", presult);
		return "WMS/detail.jsp";
	}

	@GetMapping("/bak/deletebid/{id}")
	public String delectBookingId(@PathVariable Long id) {
		bDao.deleteById(id);
		return "redirect:/ordertest";
	}

	@GetMapping("/bak/bookingForMember")
	public String bookingFormember() {
		return "/WMS/booking.html";
	}

}
