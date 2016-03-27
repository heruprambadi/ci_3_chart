<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Laporan_model extends CI_Model {

	public function opt_tahun(){
		$tahun = array(0 => 'Pilih Tahun');
		$tahun_sekarang = date('Y');
		for ($i = 2015 ; $i <= ($tahun_sekarang + 1) ; $i++) { 
			$tahun[$i] = $i;
		}

		return $tahun;
	}

	

}

/* End of file Laporan_model.php */
/* Location: ./application/models/Laporan_model.php */