import 'package:agri_trade/constraints/consts.dart';
import 'package:agri_trade/controller/controllers.dart';
import 'package:agri_trade/model/product_model.dart';
import 'package:agri_trade/screens/portals/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';

class AdminPortal extends StatefulWidget {
  const AdminPortal({super.key});

  @override
  State<AdminPortal> createState() => _AdminPortalState();
}

class _AdminPortalState extends State<AdminPortal> {
  double totalRevenue = 0;

  @override
  void initState() {
    super.initState();
    fetchRevenue();
    adminController.fetchFarmers();
    adminController.fetchUserCount();
    productController.fetchAllProducts();
  }

  Future<void> fetchRevenue() async {
    try {
      totalRevenue = await getTotalCompletedPayments();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome Admin",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Responsive Stats Grid
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isTablet ? 4 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: isTablet ? 1.5 : 1.3,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      final stats = [
                        {
                          'icon': Icons.monetization_on,
                          'title': 'Revenue',
                          'value': '$totalRevenue PKR',
                          'color': Colors.blue
                        },
                        {
                          'icon': Iconsax.profile_2user,
                          'title': 'Total Farmers',
                          'value': '${adminController.farmers.length}',
                          'color': Colors.green
                        },
                        {
                          'icon': Iconsax.user,
                          'title': 'Total Users',
                          'value': '${adminController.userCount.value}',
                          'color': Colors.purple
                        },
                        {
                          'icon': Icons.production_quantity_limits_rounded,
                          'title': 'Total Products',
                          'value':
                              '${productController.filteredProducts.length}',
                          'color': Colors.orange
                        },
                      ];
                      return _buildStatCard(
                        icon: stats[index]['icon'] as IconData,
                        title: stats[index]['title'] as String,
                        value: stats[index]['value'] as String,
                        color: stats[index]['color'] as Color,
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Improved Charts Section
                  Container(
                    height: 400,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Farmers Balance Distribution",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            _buildChartLegend(),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: _buildResponsiveChart(constraints.maxWidth),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Farmers List
                  Text(
                    "All Farmers",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.grey[50], // Light grey background
                    child: _buildFarmersList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResponsiveChart(double width) {
    if (adminController.farmers.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxBalance(),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${adminController.farmers[group.x].name}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${rod.toY.toStringAsFixed(2)} PKR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          // bottomTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     reservedSize: 30,
          //     getTitlesWidget: (value, meta) {
          //       if (value.toInt() >= adminController.farmers.length) {
          //         return const SizedBox();
          //       }
          //       final name = adminController.farmers[value.toInt()].name ?? '';
          //       return Padding(
          //         padding: const EdgeInsets.only(top: 8.0),
          //         child: Text(
          //           name.length > 3 ? '${name.substring(0, 3)}...' : name,
          //           maxLines: 2,
          //           style: const TextStyle(fontSize: 12),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 60,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} PKR',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          horizontalInterval: _getMaxBalance() / 5,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        barGroups: _generateBarGroups(),
      ),
    );
  }

  Widget _buildFarmersList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: adminController.farmers.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final farmer = adminController.farmers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListPage(
                    farmerId: '${farmer.uid}',
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Profile Image Section
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: const AssetImage(
                          'assets/brand_artworks/default_prodile_pic.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Info Section
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            farmer.name ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            farmer.email ?? 'No Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${farmer.balance} PKR', //farmer revenue
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Status/Action Section
                    const SizedBox(width: 8),
                    if (farmer.role == 'admin')
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.verified_user,
                          color: Colors.green,
                          size: 20,
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Farmer'),
                              content: const Text(
                                  'Are you sure you want to delete this farmer?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    adminController.deleteFarmer(farmer.uid!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return adminController.farmers.asMap().entries.map((entry) {
      return BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: double.parse(entry.value.balance?.toString() ?? '0'),
            color: Colors.blue.withOpacity(0.8),
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _getMaxBalance(),
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      );
    }).toList();
  }

  Widget _buildChartLegend() {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: Colors.blue.withOpacity(0.8),
        ),
        const SizedBox(width: 4),
        const Text('Balance'),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getMaxBalance() {
    if (adminController.farmers.isEmpty) return 1000;
    return adminController.farmers
            .map((farmer) => double.parse(farmer.balance?.toString() ?? '0'))
            .reduce((max, value) => max > value ? max : value) *
        1.2;
  }
}

Future<double> getTotalCompletedPayments() async {
  final String secretKey = stripeSecretKey; // Use your secret key
  final url = Uri.parse('https://api.stripe.com/v1/charges?limit=100');

  final response = await http.get(url, headers: {
    'Authorization': 'Bearer $secretKey',
  });

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // Filter for charges that are successful (paid) and in PKR, and not refunded
    final totalRevenue = data['data']
        .where((charge) =>
            charge['paid'] == true &&
            charge['refunded'] == false &&
            charge['currency'] == 'pkr')
        .fold(0, (sum, charge) => sum + charge['amount']);

    return totalRevenue / 100;
  } else {
    throw Exception('Failed to load completed payments: ${response.body}');
  }
}

class ProductListPage extends StatelessWidget {
  final String farmerId;

  ProductListPage({required this.farmerId});

  @override
  Widget build(BuildContext context) {
    adminController.fetchProductsByFarmer(farmerId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Products',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: Obx(() {
          final farmerProducts = adminController.products
              .where((p) => p.farmerID == farmerId)
              .toList();

          if (farmerProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No products available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: farmerProducts.length,
            itemBuilder: (context, index) {
              final product = farmerProducts[index];
              return ProductCard(
                product: product,
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Product'),
                      content: Text(
                          'Are you sure you want to delete ${product.name}?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            adminController.deleteProduct(product.productID!);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: Hero(
                      tag: 'product-${product.productID}',
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Product Details
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${product.price.toStringAsFixed(2)} PKR',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Delete Button
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                    onPressed: onDelete,
                    splashRadius: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
