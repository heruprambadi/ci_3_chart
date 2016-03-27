<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Laporan extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		
		$this->load->model('laporan_model');
		$this->tabel = 'monev';
	}

	public function detail($tahun="")
	{
		if ($this->input->post('tahun')) {
			redirect('chart/laporan/detail/'.$this->input->post('tahun'),'refresh');
		}
			$opt_tahun = $this->laporan_model->opt_tahun();

			//Config Halaman
			$data['judul_besar'] = 'Monev';
			$data['judul_kecil'] = 'Laporan';
			$data['m_laporan'] = TRUE;
			$data['m_laporan_detail'] = TRUE;
			$data['pertanyaan'] = $this->db->select('indikator.indikator, pertanyaan_detail.ketercapaian, pertanyaan_detail.id')
										   ->join('monev', 'monev.kode_kegiatan=pertanyaan.kode_kegiatan')
										   ->join('pertanyaan_detail', 'pertanyaan_detail.id_pertanyaan=pertanyaan.id')
										   ->join('indikator', 'indikator.id_indikator=pertanyaan_detail.id_indikator')
										   ->where('pertanyaan.kode_kegiatan', $this->uri->segment(4))
										   ->get('pertanyaan')->result();
			$data['custom_html'] = form_open('chart/laporan/detail');
			$data['custom_html'] .= '<div class="box-body">';
            $data['custom_html'] .= '<div class="row">';
            $data['custom_html'] .= '<div class="col-xs-3">';
            $data['custom_html'] .= '<div class="input-group input-group-sm">';
			$data['custom_html'] .= form_dropdown('tahun', $opt_tahun, $tahun, 'class="form-control"');
            $data['custom_html'] .= '<span class="input-group-btn">';
			$data['custom_html'] .= form_submit('name', 'Submit', 'class="btn btn-success"');
			$data['custom_html'] .= '</span>';
			$data['custom_html'] .= '</div>';
			$data['custom_html'] .= '</div>';
			$data['custom_html'] .= '</div>';
			$data['custom_html'] .= '</div>';
			$data['custom_html'] .= form_close();

			//CHART
			$this->load->library('highcharts');
		
			// some data series
			if ($this->_ar_data($tahun)) {
				$result = $this->_ar_data($tahun);
				
				// set data for conversion
				$this->highcharts->set_title('Data Grafik Poin Monev', 'Tahun '.$tahun);
				$dat1['x_labels'] 	= 'contries'; // optionnal, set axis categories from result row
				$dat1['series'] 	= array('Poin'); // set values to create series, values are result rows
				$dat1['data']		= $result;
				
				// just made some changes to display only one serie with custom name
				$dat2 = $dat1;
				$dat2['series'] = array('custom name' => 'users');
				
				
				// displaying muli graphs
				$this->highcharts->from_result($dat1)->add(); // first graph: add() register the graph
				$data['charts'] = $this->highcharts->render();
			}

			$this->load->view('view', $data, FALSE);
	}

	function _data($tahun)
	{
		$dt = $this->db->select('SUM(ketercapaian) total_nilai, pertanyaan.kode_kegiatan kode_kegiatan, lembaga.nama_lembaga nama_lembaga')
										   ->join('monev', 'monev.kode_kegiatan=pertanyaan.kode_kegiatan')
										   ->join('pertanyaan_detail', 'pertanyaan_detail.id_pertanyaan=pertanyaan.id')
										   ->join('indikator', 'indikator.id_indikator=pertanyaan_detail.id_indikator')
										   ->join('lembaga', 'lembaga.id_lembaga=monev.badan_yang_diaudit')
										   ->where('monev.tahun', $tahun)
										   ->group_by('pertanyaan.kode_kegiatan')
										   ->order_by('pertanyaan_detail.id', 'ASC')
										   ->get('pertanyaan')->result();
		if ($dt) {
			$nilai = array();
			$nama_lembaga = array();
			foreach ($dt as $key => $value) {
				$nilai[$value->total_nilai] = $value->total_nilai;
				$nama_lembaga[$value->total_nilai] = $value->nama_lembaga;
			}
			foreach ($nilai as $key => $value) {
				$total_nilai[] = (int)$value;
			}
			foreach ($nama_lembaga as $key => $value) {
				$namalembaga[] = $value;
			}


			$data['users']['data'] = $total_nilai;
			$data['users']['name'] = 'Users by Language';
			$data['axis']['categories'] = $namalembaga;
			return $data;
		}
		
	}

	function _ar_data($tahun="")
	{
		if ($this->_data($tahun)) {
			$data = $this->_data($tahun);
			foreach ($data['users']['data'] as $key => $val)
			{
				$output[] = (object)array(
					'users' 		=> $val,
					'Poin'	=> $data['users']['data'][$key],
					'contries'		=> $data['axis']['categories'][$key]
				);
			}
			return $output;
		}
		
	}

}

/* End of file Laporan.php */
/* Location: ./application/controllers/Laporan.php */