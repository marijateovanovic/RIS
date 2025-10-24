package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the id_friend_requests database table.
 * 
 */
@Entity
@Table(name="id_friend_requests")
@NamedQuery(name="FriendRequest.findAll", query="SELECT f FROM FriendRequest f")
public class FriendRequest implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	@Column(name="sent_at")
	private Timestamp sentAt;

	private String status;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="sender_id")
	private User idUser1;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="receiver_id")
	private User idUser2;

	public FriendRequest() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Timestamp getSentAt() {
		return this.sentAt;
	}

	public void setSentAt(Timestamp sentAt) {
		this.sentAt = sentAt;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
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

}