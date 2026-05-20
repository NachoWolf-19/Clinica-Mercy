package pojo;

public class Usuario {
	private final int usuarioID;
	private String usuarioNombre;
	private String usuarioClave;
	private Rol r;

	public Usuario() {
		this.usuarioID = 0;
	}

	public Usuario(int usuarioID, String usuarioNombre, String usuarioClave, Rol r) {
		this.usuarioID = usuarioID;
		this.usuarioNombre = usuarioNombre;
		this.usuarioClave = usuarioClave;
		this.r = r;
	}

	public Usuario(String usuarioNombre, String usuarioClave, Rol r) {
		this.usuarioID = 0;
		this.usuarioNombre = usuarioNombre;
		this.usuarioClave = usuarioClave;
		this.r = r;
	}

	public String getUsuarioNombre() {
		return usuarioNombre;
	}

	public void setUsuarioNombre(String usuarioNombre) {
		this.usuarioNombre = usuarioNombre;
	}

	public String getUsuarioClave() {
		return usuarioClave;
	}

	public void setUsuarioClave(String usuarioClave) {
		this.usuarioClave = usuarioClave;
	}

	public Rol getRol() {
		return r;
	}

	public void setRol(Rol r) {
		this.r = r;
	}

	public int getUsuarioID() {
		return usuarioID;
	}
}
