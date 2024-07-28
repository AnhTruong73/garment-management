// models/order.dart
class Order {
  final int id;
  final String orderId;
  final String fullName;
  final String phoneNumber;
  final num totalAmount;
  final String customerId;
  final String email;
  final String shippingAddress;
  final String status;
  final String shippingMethod;
  final String estDelivery;
  final String actualDelivery;
  final String branchId;
  final String creUsrId;
  final DateTime creDt;
  final String updUsrId;
  final DateTime updDt;
  final List<SewingTicket> sewingTickets;
  final Branch branch;
  final Customer customer;

  Order({
    required this.id,
    required this.orderId,
    required this.fullName,
    required this.phoneNumber,
    required this.totalAmount,
    required this.customerId,
    required this.email,
    required this.shippingAddress,
    required this.status,
    required this.shippingMethod,
    required this.estDelivery,
    required this.actualDelivery,
    required this.branchId,
    required this.creUsrId,
    required this.creDt,
    required this.updUsrId,
    required this.updDt,
    required this.sewingTickets,
    required this.branch,
    required this.customer,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['orderId'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      totalAmount: json['totalAmount'],
      customerId: json['customerId'],
      email: json['email'],
      shippingAddress: json['shippingAddress'],
      status: json['status'],
      shippingMethod: json['shippingMethod'],
      estDelivery: json['est_delivery'],
      actualDelivery: json['actual_delivery'],
      branchId: json['branchId'],
      creUsrId: json['cre_usr_id'],
      creDt: DateTime.parse(json['cre_dt']),
      updUsrId: json['upd_usr_id'],
      updDt: DateTime.parse(json['upd_dt']),
      sewingTickets: (json['sewingticket'] as List)
          .map((i) => SewingTicket.fromJson(i))
          .toList(),
      branch: Branch.fromJson(json['branch']),
      customer: Customer.fromJson(json['customer']),
    );
  }
}

class SewingTicket {
  final int id;
  final String sewingTicketId;
  final String orderId;
  final num height;
  final num weight;
  final num bust;
  final num waist;
  final num hips;
  final num price;
  final String status;
  final String productId;
  final String branchId;
  final String creUsrId;
  final DateTime creDt;
  final String updUsrId;
  final DateTime updDt;

  SewingTicket({
    required this.id,
    required this.sewingTicketId,
    required this.orderId,
    required this.height,
    required this.weight,
    required this.bust,
    required this.waist,
    required this.hips,
    required this.price,
    required this.status,
    required this.productId,
    required this.branchId,
    required this.creUsrId,
    required this.creDt,
    required this.updUsrId,
    required this.updDt,
  });

  factory SewingTicket.fromJson(Map<String, dynamic> json) {
    return SewingTicket(
      id: json['id'],
      sewingTicketId: json['sewingTicketId'],
      orderId: json['orderId'],
      height: json['height'],
      weight: json['weight'],
      bust: json['bust'],
      waist: json['waist'],
      hips: json['hips'],
      price: json['price'],
      status: json['status'],
      productId: json['productId'],
      branchId: json['branchId'],
      creUsrId: json['cre_usr_id'],
      creDt: DateTime.parse(json['cre_dt']),
      updUsrId: json['upd_usr_id'],
      updDt: DateTime.parse(json['upd_dt']),
    );
  }
}

class Branch {
  final String areaId;
  final String areaNm;
  final String branchId;
  final String branchNm;
  final String email;
  final String phone;
  final String address;
  final String delYn;
  final String creUsrId;
  final DateTime creDt;
  final String updUsrId;
  final DateTime updDt;
  final String headofficeYn;

  Branch({
    required this.areaId,
    required this.areaNm,
    required this.branchId,
    required this.branchNm,
    required this.email,
    required this.phone,
    required this.address,
    required this.delYn,
    required this.creUsrId,
    required this.creDt,
    required this.updUsrId,
    required this.updDt,
    required this.headofficeYn,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      areaId: json['area_id'],
      areaNm: json['area_nm'],
      branchId: json['branch_id'],
      branchNm: json['branch_nm'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      delYn: json['del_yn'],
      creUsrId: json['cre_usr_id'],
      creDt: DateTime.parse(json['cre_dt']),
      updUsrId: json['upd_usr_id'],
      updDt: DateTime.parse(json['upd_dt']),
      headofficeYn: json['headoffice_yn'],
    );
  }
}

class Customer {
  final String customerId;
  final String customerNm;
  final String email;
  final DateTime birthday;
  final String delYn;
  final String gender;
  final String address;
  final String phone;
  final String creUsrId;
  final DateTime creDt;
  final String updUsrId;
  final DateTime updDt;

  Customer({
    required this.customerId,
    required this.customerNm,
    required this.email,
    required this.birthday,
    required this.delYn,
    required this.gender,
    required this.address,
    required this.phone,
    required this.creUsrId,
    required this.creDt,
    required this.updUsrId,
    required this.updDt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerId: json['customer_id'],
      customerNm: json['customer_nm'],
      email: json['email'],
      birthday: DateTime.parse(json['birthday']),
      delYn: json['del_yn'],
      gender: json['gender'],
      address: json['address'],
      phone: json['phone'],
      creUsrId: json['cre_usr_id'],
      creDt: DateTime.parse(json['cre_dt']),
      updUsrId: json['upd_usr_id'],
      updDt: DateTime.parse(json['upd_dt']),
    );
  }
}
