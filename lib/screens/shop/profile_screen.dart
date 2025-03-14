import 'package:agri_trade/common/custom_appbar.dart';
import 'package:agri_trade/common/custom_list_tile.dart';
import 'package:agri_trade/common/feedback_widget.dart';
import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/model/orderModel.dart';
import 'package:agri_trade/screens/agricultural_info.dart';
import 'package:agri_trade/screens/cart.dart';
import 'package:agri_trade/screens/user_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    profileController.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // -- Header
            const AccountHeader(),

            // -- Body
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Settings",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomListTile(
                      icon: Iconsax.profile_tick,
                      title: "My Profile",
                      subTitle: "update your profile data",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeInfo(),
                            ));
                      }),
                  CustomListTile(
                    icon: Iconsax.shopping_bag,
                    title: "My Cart",
                    subTitle: "Add, remove products and move to checkout page",
                    onPressed: () => Get.to(() => const Cart()),
                  ),
                  CustomListTile(
                      icon: Iconsax.check,
                      title: "My Orders",
                      subTitle: "In-progress and completed orders",
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(),
                            ));
                      }),

                  CustomListTile(
                      icon: Iconsax.information,
                      title: "Agricultural Info",
                      subTitle: "Check Crops Information",
                      onPressed: () => Get.to(() =>  ChatbotScreen())),

                  // -- App Settings

                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    "App Settings",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  // CustomListTile(
                  //     icon: Iconsax.notification,
                  //     title: "Notifications",
                  //     subTitle: "Set any kind of notifications message",
                  //     onPressed: () {}),
                  // CustomListTile(
                  //     icon: Iconsax.activity,
                  //     title: "Activity Monitoring",
                  //     subTitle: "Check app usage",
                  //     onPressed: () {}),
                  CustomListTile(
                    icon: Iconsax.watch_status,
                    title: "Feedback and Report",
                    subTitle: "Report or give us your feedback",
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        builder: (context) => const FeedbackBottomSheet(),
                      );
                    },
                  ),


                  CustomListTile(
                      icon: Iconsax.logout,
                      title: "Logout",
                      subTitle: "Are you sure?",
                      onPressed: () {
                        authController.logout();
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          CustomAppBar(
            titleWidget: Text(
              "Account",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Obx(
              () => ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: profileController.user.value.url == null ||
                            profileController.user.value.url == ""
                        ? const Image(
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                            image: AssetImage(
                                "assets/brand_artworks/default_prodile_pic.png"),
                          )
                        : Image.network(
                            profileController.user.value.url!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.contain,
                          ),
                  ),
                ),
                title: Text(
                  profileController.user.value.name ?? "new user",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ),
                subtitle: Text(
                  profileController.user.value.email ?? "suport@agri_trade.com",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
                ),
                // trailing: IconButton(
                //   icon: const Icon(
                //     Iconsax.edit,
                //     color: Colors.white,
                //   ),
                //   onPressed: () {},
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeInfo extends StatefulWidget {
  @override
  _ChangeInfoState createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  // Initialize TextEditingControllers with default values
  final TextEditingController addressController =
      TextEditingController(text: profileController.user.value.address ?? '');
  final TextEditingController phoneController =
      TextEditingController(text: profileController.user.value.phone ?? '');
  final TextEditingController cnicController =
      TextEditingController(text: profileController.user.value.cnic ?? '');

  @override
  void initState() {
    super.initState();
    // Fetch user details when the widget initializes
    profileController.getUserDetails();
  }

  // Function to handle form submission
  void _submit() async {
    // Get the input values
    String address = addressController.text;
    String phone = phoneController.text;
    String cnic = cnicController.text;

    // Update user details via your controller
    await authController.updateUserDetails(
      userId: profileController.user.value.uid ?? '',
      newAddress: address,
      newCnic: cnic,
      newPhone: phone,
    );

    // Fetch the updated user details after the update
    await profileController.getUserDetails();

    // Trigger a rebuild after the update is done
    setState(() {});

    // Show confirmation or success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User details updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Shopping Delivery Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Address Field
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16),

              // Phone Field
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),

              // CNIC Field
              TextField(
                controller: cnicController,
                decoration: InputDecoration(
                  labelText: 'CNIC',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),

              // Update Button
              Center(
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Update'),
                ),
              ),
              // Showing updated phone after data refresh
              Obx(() => Text(
                    profileController.user.value.phone ?? '',
                    style: TextStyle(color: Colors.transparent),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch orders when screen loads
    cartController.fetchUserOrders(profileController.user.value.uid ?? "");

    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (cartController.orders.isEmpty) {
          return Center(child: Text('No orders found'));
        }

        return ListView.builder(
          itemCount: cartController.orders.length,
          itemBuilder: (context, index) {
            var order = cartController.orders[index];
            return OrderCard(order: order);
          },
        );
      }),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Receipt',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                Text(
                  'Order ID: ${order.productId}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.green[700], thickness: 2),
            SizedBox(height: 12),

            // Product Details
            _buildSectionTitle('Product Details'),
            _buildDetailRow('Product Name', order.productName),
            _buildDetailRow(
                'Product Price', '\$${order.productPrice.toStringAsFixed(2)}'),
            _buildDetailRow(
                'Transaction Date',
                order.transactionDate != null
                    ? DateFormat('dd MMM yyyy, hh:mm a')
                        .format(order.transactionDate!)
                    : 'N/A'),

            SizedBox(height: 12),
            Divider(color: Colors.grey[300]),
            SizedBox(height: 12),

            // Buyer Details
            _buildSectionTitle('Buyer Information'),
            _buildDetailRow('Name', order.buyerName),
            _buildDetailRow('Email', order.buyerEmail),
            _buildDetailRow('Phone', order.buyerPhone),
            _buildDetailRow('Address', order.buyerAddress),

            SizedBox(height: 12),
            Divider(color: Colors.grey[300]),
            SizedBox(height: 12),

            // Farmer Details
            _buildSectionTitle('Farmer Information'),
            _buildDetailRow('Name', order.farmerName),
            _buildDetailRow('Email', order.farmerEmail),
            _buildDetailRow('Phone', order.farmerPhone),
            _buildDetailRow('Address', order.farmerAddress),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not Provided' : value,
              style: TextStyle(
                color: value.isEmpty ? Colors.grey : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green[800],
        ),
      ),
    );
  }
}
