package pojo;

public class Especialidad {
	private final int especialidadID;
	private String especialidadNombre;
	private String especialidadEstado;

	public Especialidad() {
		this.especialidadID = 0;
	}

	public Especialidad(int especialidadID, String especialidadNombre, String especialidadEstado) {
		this.especialidadID = especialidadID;
		this.especialidadNombre = especialidadNombre;
		this.especialidadEstado = especialidadEstado;
	}

	public Especialidad(String especialidadNombre, String especialidadEstado) {
		this.especialidadID = 0;
		this.especialidadNombre = especialidadNombre;
		this.especialidadEstado = especialidadEstado;
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

	public String getEspecialidadEstado() {
		return especialidadEstado;
	}

	public void setEspecialidadEstado(String especialidadEstado) {
		this.especialidadEstado = especialidadEstado;
	}
}
