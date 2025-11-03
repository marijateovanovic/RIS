package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the id_messages database table.
 * 
 */
@Entity
@Table(name="messages")
@NamedQuery(name="Message.findAll", query="SELECT m FROM Message m")
public class Message implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	@Lob
	private String content;

	@Column(name="sent_at")
	private Timestamp sentAt;

	@Column(name="is_read")
	private boolean isRead;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="sender_id")
	private User idUser1;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="receiver_id")
	private User idUser2;

	public Message() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Timestamp getSentAt() {
		return this.sentAt;
	}

	public void setSentAt(Timestamp sentAt) {
		this.sentAt = sentAt;
	}

	public User getIdUser1() {
		return this.idUser1;
	}

	public void setIdUser1(User idUser1) {
		this.idUser1 = idUser1;
	}

	public User getIdUser2() {
		return this.idUser2;
	}

	public void setIdUser2(User idUser2) {
		this.idUser2 = idUser2;
	}

	public boolean isRead() {
		return this.isRead;
	}

	public void setRead(boolean isRead) {
		this.isRead = isRead;
	}

}