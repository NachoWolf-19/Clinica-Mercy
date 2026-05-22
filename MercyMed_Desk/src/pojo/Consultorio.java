package pojo;

public class Consultorio {
	private final int consultorioID;
	private String consultorioCodigo;
	private String consultorioEstado;

	public Consultorio() {
		this.consultorioID = 0;
	}

	public Consultorio(int consultorioID, String consultorioCodigo, String consultorioEstado) {
		this.consultorioID = consultorioID;
		this.consultorioCodigo = consultorioCodigo;
		this.consultorioEstado = consultorioEstado;
	}

	public Consultorio(String consultorioCodigo, String consultorioEstado) {
		this.consultorioID = 0;
		this.consultorioCodigo = consultorioCodigo;
		this.consultorioEstado = consultorioEstado;
	}

	public String getConsultorioCodigo() {
		return consultorioCodigo;
	}

	public void setConsultorioCodigo(String consultorioCodigo) {
		this.consultorioCodigo = consultorioCodigo;
	}

	public int getConsultorioID() {
		return consultorioID;
	}

	public String getConsultorioEstado() {
		return consultorioEstado;
	}

	public void setConsultorioEstado(String consultorioEstado) {
		this.consultorioEstado = consultorioEstado;
	}
}
