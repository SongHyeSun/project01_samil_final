package com.oracle.samil.TrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Mail;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MailDaoImpl implements MailDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;
	
	@Override
	public List<Mail> getMailList(int empno) {
	List<Mail> mailList= null;
		try {
			mailList=session.selectList("trGetMailList",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mailList;
	}

	@Override
	public List<EmpDept> SearchEmpMail(String keyword) {
		List<EmpDept> empDeptList=null;
		try {
			empDeptList=session.selectList("trSearchEmpDeptMail",keyword);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return empDeptList;
	}

	@Override
	public List<Mail> getReadMailList(int empno) {
		List<Mail> mailList= null;
		try {
			mailList=session.selectList("trGetReadMailList",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mailList;
	}

	@Override
	public List<Mail> getNotMailList(int empno) {
		List<Mail> mailList= null;
		try {
			mailList=session.selectList("trGetNotReadMailList",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mailList;
	}

	@Override
	public List<Mail> getImportantMailList(int empno) {
		List<Mail> mailList= null;
		try {
			mailList=session.selectList("trGetImportantMailList",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mailList;
	}

	@Override
	public List<Mail> getSendMailList(int empno) {
		List<Mail> mailList= null;
		try {
			mailList=session.selectList("trGetSendMailList",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mailList;
	}

	@Override
	public List<Mail> getTrashMailList(int empno) {
		List<Mail> mailList= null;
		try {
			mailList=session.selectList("trGetTrashMailList",empno);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mailList;
	}

	@Override
	public Mail MailDetail(String mailNo) {
		Mail mail= null;
		try {
			mail=session.selectOne("trGetMailDetail",mailNo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return mail;
	}

	@Override
	public void ChangeToRead(String mailNo) {
		try {
			session.update("trChangeToRead",mailNo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

	@Override
	public void deleteMail(String mailNo) {
		try {
			session.update("trMailDelete",mailNo);
			System.out.println(mailNo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	@Override
	public void sendMail(Mail mail) {
		TransactionStatus txStatus= transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			session.insert("trSendMailforMe",mail);
			session.insert("trSendMailforYou",mail);
			
			transactionManager.commit(txStatus);
	} catch (Exception e) {
		System.out.println(e.getMessage());
		transactionManager.rollback(txStatus);
	}
		
	}

	@Override
	public void importantMailCheck(int mailNo) {
		System.out.println("change mail importance dao1");
		try {
			session.update("trImportantMailCheck",mailNo);
			System.out.println("change mail importance dao2");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
	}

	@Override
	public void deleteMailReal(String mailNo) {
		
		System.out.println("deleteMailReal");
		try {
			session.delete("trDeleteMailReal",mailNo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}
