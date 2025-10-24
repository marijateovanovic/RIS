package model;

import java.io.Serializable;
import jakarta.persistence.*;


/**
 * The persistent class for the id_friendships database table.
 * 
 */
@Entity
@Table(name="id_friendships")
@NamedQuery(name="Friendship.findAll", query="SELECT f FROM Friendship f")
public class Friendship implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="user1_id")
	private User idUser1;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="user2_id")
	private User idUser2;

	public Friendship() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
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