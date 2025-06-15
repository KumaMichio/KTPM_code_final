package controller;

import java.net.URL;
import java.sql.SQLException;
import java.util.List;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Label;
import models.HoKhauModel;
import models.KhoanThuModel;
import models.NhanKhauModel;
import models.NopTienModel;
import services.HoKhauService;
import services.KhoanThuService;
import services.NhanKhauService;
import services.NopTienService;

public class MainController implements Initializable{
	@FXML
	private Label lbSoHoKhau;

	@FXML
	private Label lbSoKhoanThu;

	@FXML
	private Label lbSoNhanKhau;

	@FXML
	private Label lbTongTienKhoanThu;

	@FXML
	private LineChart<String, Number> paymentHistoryChart;

	private NopTienService nopTienService;  // Declare NopTienService here
	private KhoanThuService khoanThuService;


	@Override
	public void initialize(URL arg0, ResourceBundle arg1) {
		// Instantiate the services
		nopTienService = new NopTienService();
		khoanThuService = new KhoanThuService();
		try {
			List<HoKhauModel> listHoKhau = new HoKhauService().getListHoKhau();
			long soHoKhau = listHoKhau.stream().count();
			lbSoHoKhau.setText(Long.toString(soHoKhau));
			
			List<KhoanThuModel> listKhoanThu = new KhoanThuService().getListKhoanThu();
			long soKhoanThu = listKhoanThu.stream().count();
			lbSoKhoanThu.setText(Long.toString(soKhoanThu));

			List<NhanKhauModel> listNhanKhau = new NhanKhauService().getListNhanKhau();
			long soNhanKhau = listNhanKhau.stream().count();
			lbSoNhanKhau.setText(Long.toString(soNhanKhau));

			// Fetch the NopTien data (payments)
			List<NopTienModel> listNopTien = nopTienService.getListNopTien();

			// Calculate the total amount from NopTien (soTien)
			double totalAmount = 0.0;
			for (NopTienModel nopTien : listNopTien) {
				totalAmount += nopTien.getSoTien(khoanThuService);  // Fetch the amount from KhoanThuModel based on maKhoanThu
			}
			lbTongTienKhoanThu.setText(String.format("%.2f", totalAmount));  // Format to 2 decimal places

			// Populate the LineChart with NopTien data
			XYChart.Series<String, Number> series = new XYChart.Series<>();
			series.setName("Payment History");

			for (NopTienModel nopTien : listNopTien) {
				String date = nopTien.getNgayThu().toString();  // Convert the date to string
				double amount = nopTien.getSoTien(khoanThuService);  // Use the dynamic 'soTien' for the y-axis

				// Add data points to the series
				series.getData().add(new XYChart.Data<>(date, amount));
			}

			// Add the series to the chart
			paymentHistoryChart.getData().add(series);
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
