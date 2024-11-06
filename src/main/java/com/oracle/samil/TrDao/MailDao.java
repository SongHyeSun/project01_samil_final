package com.oracle.samil.TrDao;

import java.util.List;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Mail;

public interface MailDao {

	List<Mail> getMailList(int empno);

	List<EmpDept> SearchEmpMail(String keyword);

	List<Mail> getReadMailList(int empno);

	List<Mail> getNotMailList(int empno);

	List<Mail> getImportantMailList(int empno);

	List<Mail> getSendMailList(int empno);

	List<Mail> getTrashMailList(int empno);

	Mail MailDetail(String mailNo);

	void ChangeToRead(String mailNo);

	void deleteMail(String mailNo);

	void sendMail(Mail mail);

	void importantMailCheck(int mailNo);

	void deleteMailReal(String mailNo);

}
