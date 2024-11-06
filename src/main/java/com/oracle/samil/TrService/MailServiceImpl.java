package com.oracle.samil.TrService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Mail;
import com.oracle.samil.TrDao.MailDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MailServiceImpl implements MailService {

	private final MailDao    md;

	@Override
	public List<Mail> getMailList(int empno) {
		List<Mail> mailList= md.getMailList(empno);
		return mailList;
	}

	@Override
	public List<EmpDept> SearchEmpMail(String keyword) {
		List<EmpDept> empDeptList= md.SearchEmpMail(keyword);
		return empDeptList;
	}

	@Override
	public List<Mail> getReadMailList(int empno) {
		List<Mail> mailList= md.getReadMailList(empno);
		return mailList;
	}

	@Override
	public List<Mail> getNotReadMailList(int empno) {
		List<Mail> mailList= md.getNotMailList(empno);
		return mailList;
	}

	@Override
	public List<Mail> getImportantMailList(int empno) {
		List<Mail> mailList= md.getImportantMailList(empno);
		return mailList;
	}

	@Override
	public List<Mail> getSendMailList(int empno) {
		List<Mail> mailList= md.getSendMailList(empno);
		return mailList;
	}

	@Override
	public List<Mail> getTrashMailList(int empno) {
		List<Mail> mailList= md.getTrashMailList(empno);
		return mailList;
	}

	@Override
	public Mail MailDetail(String mailNo) {
		Mail mail = md.MailDetail(mailNo);
		return mail;
	}

	@Override
	public void ChangeToRead(String mailNo) {
		md.ChangeToRead(mailNo);
		
	}

	@Override
	public void deleteMail(String mailNo) {
		md.deleteMail(mailNo);
		
	}

	@Override
	public void sendMail(Mail mail) {
		md.sendMail(mail);
		
	}

	@Override
	public void importantMailCheck(int mailNo) {
		System.out.println("tr Service important Mail Check");
		md.importantMailCheck(mailNo);
		
	}

	@Override
	public void deleteMailReal(String mailNo) {
		System.out.println("tr Service important Mail Check");
		md.deleteMailReal(mailNo);
		
	}


	
}
