package pojo;

public class Rol {
	private final int rolID;
	private String rolNombre;

	public Rol() {
		this.rolID = 0;
	}

	public Rol(int rolID, String rolNombre) {
		this.rolID = rolID;
		this.rolNombre = rolNombre;
	}

	public String getRolNombre() {
		return rolNombre;
	}

	public void setRolNombre(String rolNombre) {
		this.rolNombre = rolNombre;
	}

	public int getRolID() {
		return rolID;
	}
}
