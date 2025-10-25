package model;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the id_users database table.
 * 
 */
@Entity
@Table(name="id_users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;

	private String clearance;

	private String email;

	private String password;

	private String username;

	@Column(name="profile_photo_path")
	private String profilePhotoPath;

	private boolean blocked;

	//bi-directional many-to-one association to FriendRequest
	@OneToMany(mappedBy="idUser1")
	private List<FriendRequest> idFriendRequests1;

	//bi-directional many-to-one association to FriendRequest
	@OneToMany(mappedBy="idUser2")
	private List<FriendRequest> idFriendRequests2;

	//bi-directional many-to-one association to Friendship
	@OneToMany(mappedBy="idUser1")
	private List<Friendship> idFriendships1;

	//bi-directional many-to-one association to Friendship
	@OneToMany(mappedBy="idUser2")
	private List<Friendship> idFriendships2;

	//bi-directional many-to-one association to Message
	@OneToMany(mappedBy="idUser1")
	private List<Message> idMessages1;

	//bi-directional many-to-one association to Message
	@OneToMany(mappedBy="idUser2")
	private List<Message> idMessages2;

	//bi-directional many-to-one association to Post
	@OneToMany(mappedBy="idUser")
	private List<Post> idPosts;

	public User() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getClearance() {
		return this.clearance;
	}

	public void setClearance(String clearance) {
		this.clearance = clearance;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getProfilePhotoPath() {
		return this.profilePhotoPath;
	}

	public void setProfilePhotoPath(String profilePhotoPath) {
		this.profilePhotoPath = profilePhotoPath;
	}

	public boolean isBlocked() {
		return this.blocked;
	}

	public void setBlocked(boolean blocked) {
		this.blocked = blocked;
	}

	public List<FriendRequest> getIdFriendRequests1() {
		return this.idFriendRequests1;
	}

	public void setIdFriendRequests1(List<FriendRequest> idFriendRequests1) {
		this.idFriendRequests1 = idFriendRequests1;
	}

	public FriendRequest addIdFriendRequests1(FriendRequest idFriendRequests1) {
		getIdFriendRequests1().add(idFriendRequests1);
		idFriendRequests1.setIdUser1(this);

		return idFriendRequests1;
	}

	public FriendRequest removeIdFriendRequests1(FriendRequest idFriendRequests1) {
		getIdFriendRequests1().remove(idFriendRequests1);
		idFriendRequests1.setIdUser1(null);

		return idFriendRequests1;
	}

	public List<FriendRequest> getIdFriendRequests2() {
		return this.idFriendRequests2;
	}

	public void setIdFriendRequests2(List<FriendRequest> idFriendRequests2) {
		this.idFriendRequests2 = idFriendRequests2;
	}

	public FriendRequest addIdFriendRequests2(FriendRequest idFriendRequests2) {
		getIdFriendRequests2().add(idFriendRequests2);
		idFriendRequests2.setIdUser2(this);

		return idFriendRequests2;
	}

	public FriendRequest removeIdFriendRequests2(FriendRequest idFriendRequests2) {
		getIdFriendRequests2().remove(idFriendRequests2);
		idFriendRequests2.setIdUser2(null);

		return idFriendRequests2;
	}

	public List<Friendship> getIdFriendships1() {
		return this.idFriendships1;
	}

	public void setIdFriendships1(List<Friendship> idFriendships1) {
		this.idFriendships1 = idFriendships1;
	}

	public Friendship addIdFriendships1(Friendship idFriendships1) {
		getIdFriendships1().add(idFriendships1);
		idFriendships1.setIdUser1(this);

		return idFriendships1;
	}

	public Friendship removeIdFriendships1(Friendship idFriendships1) {
		getIdFriendships1().remove(idFriendships1);
		idFriendships1.setIdUser1(null);

		return idFriendships1;
	}

	public List<Friendship> getIdFriendships2() {
		return this.idFriendships2;
	}

	public void setIdFriendships2(List<Friendship> idFriendships2) {
		this.idFriendships2 = idFriendships2;
	}

	public Friendship addIdFriendships2(Friendship idFriendships2) {
		getIdFriendships2().add(idFriendships2);
		idFriendships2.setIdUser2(this);

		return idFriendships2;
	}

	public Friendship removeIdFriendships2(Friendship idFriendships2) {
		getIdFriendships2().remove(idFriendships2);
		idFriendships2.setIdUser2(null);

		return idFriendships2;
	}

	public List<Message> getIdMessages1() {
		return this.idMessages1;
	}

	public void setIdMessages1(List<Message> idMessages1) {
		this.idMessages1 = idMessages1;
	}

	public Message addIdMessages1(Message idMessages1) {
		getIdMessages1().add(idMessages1);
		idMessages1.setIdUser1(this);

		return idMessages1;
	}

	public Message removeIdMessages1(Message idMessages1) {
		getIdMessages1().remove(idMessages1);
		idMessages1.setIdUser1(null);

		return idMessages1;
	}

	public List<Message> getIdMessages2() {
		return this.idMessages2;
	}

	public void setIdMessages2(List<Message> idMessages2) {
		this.idMessages2 = idMessages2;
	}

	public Message addIdMessages2(Message idMessages2) {
		getIdMessages2().add(idMessages2);
		idMessages2.setIdUser2(this);

		return idMessages2;
	}

	public Message removeIdMessages2(Message idMessages2) {
		getIdMessages2().remove(idMessages2);
		idMessages2.setIdUser2(null);

		return idMessages2;
	}

	public List<Post> getIdPosts() {
		return this.idPosts;
	}

	public void setIdPosts(List<Post> idPosts) {
		this.idPosts = idPosts;
	}

	public Post addIdPost(Post idPost) {
		getIdPosts().add(idPost);
		idPost.setIdUser(this);

		return idPost;
	}

	public Post removeIdPost(Post idPost) {
		getIdPosts().remove(idPost);
		idPost.setIdUser(null);

		return idPost;
	}

}