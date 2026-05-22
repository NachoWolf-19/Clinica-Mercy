package pojo;

public class Usuario {
	private final int usuarioID;
	private String usuarioNombre;
	private String usuarioClave;
	private String usuarioRol;

	public Usuario() {
		this.usuarioID = 0;
	}

	public Usuario(int usuarioID, String usuarioNombre, String usuarioClave, String usuarioRol) {
		this.usuarioID = usuarioID;
		this.usuarioNombre = usuarioNombre;
		this.usuarioClave = usuarioClave;
		this.usuarioRol = usuarioRol;
	}

	public Usuario(String usuarioNombre, String usuarioClave, String usuarioRol) {
		this.usuarioID = 0;
		this.usuarioNombre = usuarioNombre;
		this.usuarioClave = usuarioClave;
		this.usuarioRol = usuarioRol;
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

	public String getUsuarioRol() {
		return usuarioRol;
	}

	public void setUsuarioRol(String usuarioRol) {
		this.usuarioRol = usuarioRol;
	}

	public int getUsuarioID() {
		return usuarioID;
	}
}
