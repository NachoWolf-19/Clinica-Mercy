package pojo;

public class Paciente {
	private final int pacienteID;
	private String pacienteDNI;
	private String pacienteNombres;
	private String pacienteApellidos;
	private String pacienteNumero;
	private String pacienteEmail;
	private String pacienteEstado;

	public Paciente() {
		this.pacienteID = 0;
	}

	public Paciente(int pacienteID, String pacienteDNI, String pacienteNombres, String pacienteApellidos,
			String pacienteNumero, String pacienteEmail, String pacienteEstado) {
		this.pacienteID = pacienteID;
		this.pacienteDNI = pacienteDNI;
		this.pacienteNombres = pacienteNombres;
		this.pacienteApellidos = pacienteApellidos;
		this.pacienteNumero = pacienteNumero;
		this.pacienteEmail = pacienteEmail;
		this.pacienteEstado = pacienteEstado;
	}

	public Paciente(String pacienteDNI, String pacienteNombres, String pacienteApellidos, String pacienteNumero,
			String pacienteEmail, String pacienteEstado) {
		this.pacienteID = 0;
		this.pacienteDNI = pacienteDNI;
		this.pacienteNombres = pacienteNombres;
		this.pacienteApellidos = pacienteApellidos;
		this.pacienteNumero = pacienteNumero;
		this.pacienteEmail = pacienteEmail;
		this.pacienteEstado = pacienteEstado;
	}

	public String getPacienteDNI() {
		return pacienteDNI;
	}

	public void setPacienteDNI(String pacienteDNI) {
		this.pacienteDNI = pacienteDNI;
	}

	public String getPacienteNombres() {
		return pacienteNombres;
	}

	public void setPacienteNombres(String pacienteNombres) {
		this.pacienteNombres = pacienteNombres;
	}

	public String getPacienteApellidos() {
		return pacienteApellidos;
	}

	public void setPacienteApellidos(String pacienteApellidos) {
		this.pacienteApellidos = pacienteApellidos;
	}

	public String getPacienteNumero() {
		return pacienteNumero;
	}

	public void setPacienteNumero(String pacienteNumero) {
		this.pacienteNumero = pacienteNumero;
	}

	public String getPacienteEmail() {
		return pacienteEmail;
	}

	public void setPacienteEmail(String pacienteEmail) {
		this.pacienteEmail = pacienteEmail;
	}

	public String getPacienteEstado() {
		return pacienteEstado;
	}

	public void setPacienteEstado(String pacienteEstado) {
		this.pacienteEstado = pacienteEstado;
	}

	public int getPacienteID() {
		return pacienteID;
	}
}
