package pojo;

public class Consultorio {
	private final int consultorioID;
	private String consultorioCodigo;

	public Consultorio() {
		this.consultorioID = 0;
	}

	public Consultorio(int consultorioID, String consultorioCodigo) {
		this.consultorioID = consultorioID;
		this.consultorioCodigo = consultorioCodigo;
	}

	public Consultorio(String consultorioCodigo) {
		this.consultorioID = 0;
		this.consultorioCodigo = consultorioCodigo;
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
}
