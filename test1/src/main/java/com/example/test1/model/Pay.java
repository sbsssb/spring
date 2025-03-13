package com.example.test1.model;

import lombok.Data;

@Data
public class Pay {

	private String orderId;
	private String userId;
	private String amount;
	private String itemNo;
	private String paymentDate;
}
