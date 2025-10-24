package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the id_posts database table.
 * 
 */
@Entity
@Table(name="id_posts")
@NamedQuery(name="Post.findAll", query="SELECT p FROM Post p")
public class Post implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	@Lob
	private String content;

	@Column(name="created_at")
	private Timestamp createdAt;

	private String title;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="author_id")
	private User idUser;

	public Post() {
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

	public Timestamp getCreatedAt() {
		return this.createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public User getIdUser() {
		return this.idUser;
	}

	public void setIdUser(User idUser) {
		this.idUser = idUser;
	}

}