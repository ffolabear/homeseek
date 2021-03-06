package com.mvc.homeseek.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mvc.homeseek.model.dao.AdminDao;
import com.mvc.homeseek.model.dto.DonationDto;
import com.mvc.homeseek.model.dto.MemberDto;
import com.mvc.homeseek.model.dto.ReportDto;
import com.mvc.homseek.paging.Paging;

@Service
public class AdminBizImpl implements AdminBiz {
	
	@Autowired
	private AdminDao adminDao;
	@Override
	public List<MemberDto> allMember(Paging vo) {
		// TODO Auto-generated method stub
		return adminDao.allMember(vo);
	}
	@Override
	public List<ReportDto> allReport(Paging vo) {
		// TODO Auto-generated method stub
		return adminDao.allReport(vo);
	}
	
	@Override
	public ReportDto reportRes(int report_no) {
		// TODO Auto-generated method stub
		return adminDao.reportRes(report_no);
	}
	@Override
	public int countMember() {
		// TODO Auto-generated method stub
		return adminDao.countMember();
	}
	@Override
	public int countDonation() {
		// TODO Auto-generated method stub
		return adminDao.countDonation();
	}
	
	@Override
	public List<DonationDto> allDonation(Paging vo) {
		// TODO Auto-generated method stub
		return adminDao.allDonation(vo);
	}
	
	@Override
	public int rejectReport(int report_no) {
		// TODO Auto-generated method stub
		return adminDao.rejectReport(report_no);
	}
	@Override
	public int acceptReport(String report_reid) {
		// TODO Auto-generated method stub
		return adminDao.acceptReport(report_reid);
	}
	@Override
	public int acceptDelete(String report_reid) {
		// TODO Auto-generated method stub
		return adminDao.acceptDelete(report_reid);
	}
	@Override
	public List<MemberDto> NormalMember(Paging vo) {
		// TODO Auto-generated method stub
		return adminDao.NormalMember(vo);
	}
	@Override
	public int countNormal() {
		// TODO Auto-generated method stub
		return adminDao.countNormal();
	}
	@Override
	public List<MemberDto> BanMember(Paging vo) {
		// TODO Auto-generated method stub
		return adminDao.BanMember(vo);
	}
	@Override
	public int countBan() {
		// TODO Auto-generated method stub
		return adminDao.countBan();
	}
	@Override
	public int countWithdrawal() {
		// TODO Auto-generated method stub
		return adminDao.countWithdrawal();
	}
	@Override
	public List<MemberDto> WithdrawalMember(Paging vo) {
		// TODO Auto-generated method stub
		return adminDao.WithdrawalMember(vo);
	}
	@Override
	public int enableModify(String member_id) {
		// TODO Auto-generated method stub
		return adminDao.enableModify(member_id);
	}
	@Override
	public int countUpdate() {
		// TODO Auto-generated method stub
		return adminDao.countUpdate();
	}

}
