package pojo;

public class Medico {
	private final int medicoID;
	private String medicoCMP;
	private String medicoNombres;
	private String medicoApellidos;
	private String medicoEstado;
	private Especialidad e;

	public Medico() {
		this.medicoID = 0;
	}

	public Medico(int medicoID, String medicoCMP, String medicoNombres, String medicoApellidos, String medicoEstado,
			Especialidad e) {
		this.medicoID = medicoID;
		this.medicoCMP = medicoCMP;
		this.medicoNombres = medicoNombres;
		this.medicoApellidos = medicoApellidos;
		this.medicoEstado = medicoEstado;
		this.e = e;
	}

	public Medico(String medicoCMP, String medicoNombres, String medicoApellidos, String medicoEstado, Especialidad e) {
		this.medicoID = 0;
		this.medicoCMP = medicoCMP;
		this.medicoNombres = medicoNombres;
		this.medicoApellidos = medicoApellidos;
		this.medicoEstado = medicoEstado;
		this.e = e;
	}

	public String getMedicoCMP() {
		return medicoCMP;
	}

	public void setMedicoCMP(String medicoCMP) {
		this.medicoCMP = medicoCMP;
	}

	public String getMedicoNombres() {
		return medicoNombres;
	}

	public void setMedicoNombres(String medicoNombres) {
		this.medicoNombres = medicoNombres;
	}

	public String getMedicoApellidos() {
		return medicoApellidos;
	}

	public void setMedicoApellidos(String medicoApellidos) {
		this.medicoApellidos = medicoApellidos;
	}

	public String getMedicoEstado() {
		return medicoEstado;
	}

	public void setMedicoEstado(String medicoEstado) {
		this.medicoEstado = medicoEstado;
	}

	public Especialidad getEspecialidad() {
		return e;
	}

	public void setEspecialidad(Especialidad e) {
		this.e = e;
	}

	public int getMedicoID() {
		return medicoID;
	}
}
