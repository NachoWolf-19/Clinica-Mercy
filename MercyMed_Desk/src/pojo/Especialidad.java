package pojo;

public class Especialidad {
	private final int especialidadID;
	private String especialidadNombre;

	public Especialidad() {
		this.especialidadID = 0;
	}

	public Especialidad(int especialidadID, String especialidadNombre) {
		this.especialidadID = especialidadID;
		this.especialidadNombre = especialidadNombre;
	}

	public Especialidad(String especialidadNombre) {
		this.especialidadID = 0;
		this.especialidadNombre = especialidadNombre;
	}

	public String getEspecialidadNombre() {
		return especialidadNombre;
	}

	public void setEspecialidadNombre(String especialidadNombre) {
		this.especialidadNombre = especialidadNombre;
	}

	public int getEspecialidadID() {
		return especialidadID;
	}
}
