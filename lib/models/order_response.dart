class OrderResponse {
  final int? status;
  final String? message;
  final OrderData? data;

  OrderResponse({this.status, this.message, this.data});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? OrderData.fromJson(json['data']) : null,
    );
  }
}

class OrderData {
  final Order? order;
  final SewingTicket? sewingTicket;

  OrderData({this.order, this.sewingTicket});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: json['order'] != null ? Order.fromJson(json['order']) : null,
      sewingTicket: json['sewingTicket'] != null ? SewingTicket.fromJson(json['sewingTicket']) : null,
    );
  }
}

class Order {
  final String? orderId;
  final String? fullName;
  final String? phoneNumber;
  final int? totalAmount;
  final String? customerId;
  final String? email;
  final String? shippingAddress;
  final String? shippingMethod;
  final String? estDelivery;
  final String? actualDelivery;
  final String? branchId;
  final String? status;

  Order({
    this.orderId,
    this.fullName,
    this.phoneNumber,
    this.totalAmount,
    this.customerId,
    this.email,
    this.shippingAddress,
    this.shippingMethod,
    this.estDelivery,
    this.actualDelivery,
    this.branchId,
    this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      totalAmount: json['totalAmount'],
      customerId: json['customerId'],
      email: json['email'],
      shippingAddress: json['shippingAddress'],
      shippingMethod: json['shippingMethod'],
      estDelivery: json['est_delivery'],
      actualDelivery: json['actual_delivery'],
      branchId: json['branchId'],
      status: json['status'],
    );
  }
}

class SewingTicket {
  final String? sewingTicketId;
  final String? orderId;
  final int? height;
  final int? weight;
  final int? bust;
  final int? waist;
  final int? hips;
  final int? price;
  final String? productId;
  final String? branchId;
  final String? status;

  SewingTicket({
    this.sewingTicketId,
    this.orderId,
    this.height,
    this.weight,
    this.bust,
    this.waist,
    this.hips,
    this.price,
    this.productId,
    this.branchId,
    this.status,
  });

  factory SewingTicket.fromJson(Map<String, dynamic> json) {
    return SewingTicket(
      sewingTicketId: json['sewingTicketId'],
      orderId: json['orderId'],
      height: json['height'],
      weight: json['weight'],
      bust: json['bust'],
      waist: json['waist'],
      hips: json['hips'],
      price: json['price'],
      productId: json['productId'],
      branchId: json['branchId'],
      status: json['status'],
    );
  }
}
