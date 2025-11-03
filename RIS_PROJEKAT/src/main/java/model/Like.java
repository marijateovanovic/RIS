package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Timestamp;

/**
 * The persistent class for the id_likes database table.
 */
@Entity
@Table(name="likes")
@NamedQuery(name="Like.findAll", query="SELECT l FROM Like l")
public class Like implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	@Column(name="created_at")
	private Timestamp createdAt;

	// Many-to-one association to User
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;

	// Many-to-one association to Post
	@ManyToOne
	@JoinColumn(name="post_id")
	private Post post;

	public Like() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Timestamp getCreatedAt() {
		return this.createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post getPost() {
		return this.post;
	}

	public void setPost(Post post) {
		this.post = post;
	}
}

