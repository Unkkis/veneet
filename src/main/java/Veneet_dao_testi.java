import static org.junit.jupiter.api.Assertions.*;
import static org.junit.Assert.assertEquals;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import model.dao.Dao;
import model.Vene;

class Veneet_dao_testi {


	@Test
	@Order(1) 
	public void testLisaaAuto() {	//tehd‰‰n joitain veneit‰	
		Dao dao = new Dao();
		Vene vene_1 = new Vene(1, "Jolla", "Jokuvenemerkki", 9.4, 2, 10000);
		Vene vene_2 = new Vene(2, "Unelma", "Toinen venemerkki", 10.5, 2.1, 20000);
		Vene vene_3 = new Vene(3, "Sirpa-Leena", "En tunne veneit‰", 11.7, 3.3, 30000);
		assertEquals(true, dao.lisaaVene(vene_1));
		assertEquals(true, dao.lisaaVene(vene_2));
		assertEquals(true, dao.lisaaVene(vene_3));
	}
	
	@Test
	@Order(2) 
	public void testMuutaVene() {  //Tehd‰‰n muutos yhden veneen tietoihin (etsit‰‰n vene tunnuksen avulla ja muutetaan sen tiedot)
		Dao dao = new Dao();
		Vene muutettava = dao.etsiVene(3);
		muutettava.setNimi("muutettu nimi");
		muutettava.setMerkkimalli("uusi merkki tai malli");
		muutettava.setPituus(6.6);
		muutettava.setLeveys(8.8);
		muutettava.setHinta(50000);
		dao.muutaVene(muutettava);	
		assertEquals("muutettu nimi", dao.etsiVene(2).getNimi());
		assertEquals("uusi merkki tai malli", dao.etsiVene(2).getMerkkimalli());
		assertEquals(6.6, dao.etsiVene(2).getPituus(), 1);
		assertEquals(8.8, dao.etsiVene(2).getLeveys(), 1);
		assertEquals(50000, dao.etsiVene(2).getHinta());
	}
	
	@Test
	@Order(3) 
	public void testPoistaVene() {//poistetaan vene
		Dao dao = new Dao();
		dao.poistaVene(2);
		assertEquals(null, dao.etsiVene(2));
	}

}
