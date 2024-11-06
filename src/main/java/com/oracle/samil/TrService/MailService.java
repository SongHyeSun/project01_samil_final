package com.oracle.samil.TrService;

import java.util.List;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Mail;

public interface MailService {

	List<Mail> getMailList(int empno);

	List<EmpDept> SearchEmpMail(String keyword);

	List<Mail> getReadMailList(int empno);

	List<Mail> getNotReadMailList(int empno);

	List<Mail> getImportantMailList(int empno);

	List<Mail> getSendMailList(int empno);

	List<Mail> getTrashMailList(int empno);

	Mail MailDetail(String mailNo);

	void ChangeToRead(String mailNo);

	void deleteMail(String string);

	void sendMail(Mail mail);

	void importantMailCheck(int mailNo);

	void deleteMailReal(String string);

}
