package model.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Vene;

public class Dao {

	private Connection con=null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep=null; 
	private String sql;
	private String db ="Venekanta.sqlite";
	
	private Connection yhdista(){
    	Connection con = null;    	
    	String path = System.getProperty("catalina.base");
    	System.out.println(path + "  " + path.substring(0, path.indexOf(".metadata")).replace("\\", "/") );
    	path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/"); //Eclipsessa
    	//path += "/webapps/"; //Tuotannossa. Laita tietokanta webapps-kansioon
    	//path =  new File(System.getProperty("user.dir")).getParentFile().toString() +"\\"; //Testauksessa
    	System.out.println(path);
    	String url = "jdbc:sqlite:"+path+"Veneet/"+db;   
    	System.out.println(url);
    	try {	       
    		Class.forName("org.sqlite.JDBC");
	        con = DriverManager.getConnection(url);	
	        System.out.println("Yhteys avattu.");
	     }catch (Exception e){	
	    	 System.out.println("Yhteyden avaus ep?onnistui.");
	        e.printStackTrace();	         
	     }
	     return con;
	}
	
	public ArrayList<Vene> listaaKaikki(){ //haetaan kaikkien veneiden kaikki tiedot ja palautetaan niist? tehty arrayList.
		ArrayList<Vene> veneet = new ArrayList<Vene>();
		sql = "SELECT * FROM veneet";
		try {
			con=yhdista();
			if (con!=null) {
				stmtPrep =con.prepareStatement(sql);
				rs = stmtPrep.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						Vene vene = new Vene();
						vene.setTunnus(rs.getInt(1));
						vene.setNimi(rs.getString(2));
						vene.setMerkkimalli(rs.getString(3));
						vene.setPituus(rs.getDouble(4));
						vene.setLeveys(rs.getDouble(5));
						vene.setHinta(rs.getInt(6));
						veneet.add(vene);
					}
				}
			}
			con.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return veneet;
	}
	
	public ArrayList<Vene> listaaKaikki(String hakusana){//haetaan veneiden tiedot hakusanalla ja palautetaan niist? tehty arrayList
		ArrayList<Vene> veneet = new ArrayList<Vene>();
		sql = "SELECT * FROM veneet WHERE nimi LIKE ? or merkkimalli LIKE ? or pituus LIKE ? or leveys LIKE ? or hinta LIKE?";
		try {
			con=yhdista();
			if (con!=null) {
				stmtPrep = con.prepareStatement(sql);
				stmtPrep.setString(1, "%" + hakusana + "%");
				stmtPrep.setString(2, "%" + hakusana + "%");   
				stmtPrep.setString(3, "%" + hakusana + "%");
				stmtPrep.setString(4, "%" + hakusana + "%");
				stmtPrep.setString(5, "%" + hakusana + "%");
				rs = stmtPrep.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						Vene vene = new Vene();
						vene.setTunnus(rs.getInt(1));
						vene.setNimi(rs.getString(2));
						vene.setMerkkimalli(rs.getString(3));
						vene.setPituus(rs.getDouble(4));
						vene.setLeveys(rs.getDouble(5));
						vene.setHinta(rs.getInt(6));
						veneet.add(vene);
					}
				}
			}
			con.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return veneet;
	}
	
	public boolean lisaaVene(Vene vene) {//list?t??n vene
		boolean paluuArvo=true;
		sql="INSERT INTO veneet (nimi, merkkimalli, pituus, leveys, hinta) VALUES(?,?,?,?,?)";						  
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql); 
			stmtPrep.setString(1, vene.getNimi());
			stmtPrep.setString(2, vene.getMerkkimalli());
			stmtPrep.setDouble(3, vene.getPituus());
			stmtPrep.setDouble(4, vene.getLeveys());
			stmtPrep.setInt(5, vene.getHinta());		
			stmtPrep.executeUpdate();
	        con.close();
		} catch (Exception e) {				
			e.printStackTrace();
			paluuArvo=false;
		}				
		return paluuArvo;
	}
	
	public boolean poistaVene(int tunnus) {//poistetaan vene veneen tunnuksen perusteella
		boolean paluuArvo = true;
		sql="DELETE FROM veneet WHERE tunnus=?";
		try {
			con=yhdista();
			stmtPrep=con.prepareStatement(sql);
			stmtPrep.setInt(1, tunnus);
			stmtPrep.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			paluuArvo=false;
		}
		
		return paluuArvo;
	}
	public Vene etsiVene(int tunnus) { //etsit??n vene veneen tunnuksen perusteella
		Vene vene = null;
		sql = "SELECT * FROM veneet WHERE tunnus=?";
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql);
			stmtPrep.setInt(1, tunnus);
			rs = stmtPrep.executeQuery();
			System.out.println(rs);
			if(rs.isBeforeFirst()) {
				rs.next();
				vene = new Vene();
				vene.setTunnus(rs.getInt(1));
				vene.setNimi(rs.getString(2));
				vene.setMerkkimalli(rs.getString(3));
				vene.setPituus(rs.getDouble(4));
				vene.setLeveys(rs.getDouble(5));
				vene.setHinta(rs.getInt(6));
			}
			con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vene;
	}
	public boolean muutaVene(Vene vene) { //muutetaan veneen tietoja
		boolean paluuArvo=true;
		sql="UPDATE veneet SET nimi=?, merkkimalli=?, pituus=?, leveys=?, hinta=? WHERE tunnus=?";
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql);
			stmtPrep.setString(1, vene.getNimi());
			stmtPrep.setString(2, vene.getMerkkimalli());
			stmtPrep.setDouble(3, vene.getPituus());
			stmtPrep.setDouble(4, vene.getLeveys());
			stmtPrep.setInt(5, vene.getHinta());
			stmtPrep.setInt(6, vene.getTunnus());
			stmtPrep.executeUpdate();
			con.close();			
		} catch (Exception e) {
			e.printStackTrace();
			paluuArvo = false;
		}
		
		return paluuArvo;
	}
}
