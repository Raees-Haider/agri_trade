import 'package:agri_trade/screens/portals/farmer_portal/screens/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constraints/enums.dart';

class ZProductCardVertical extends StatelessWidget {
  const ZProductCardVertical({
    super.key,
    this.title,
    this.description,
    this.price,
    this.showVerificationIcon = true,
    this.showAddToCartButton = true,
    this.imageUrl,
    this.onTap,
    this.removeToCart = false,
    required this.biddingAccepted,
     this.productQuantity = 3000
  });

  final String? imageUrl;
  final String? title;
  final String? description;
  final String? price;
  final bool showVerificationIcon;
  final bool showAddToCartButton;
  final bool removeToCart;
  final bool biddingAccepted;
  final VoidCallback? onTap;
  final int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('clicked');
        Get.to( DetailPage(
          imageUrl: imageUrl,
          title: title,
          description: description,
          price: price,
          showAddToCartButton: showAddToCartButton,
          showVerificationIcon: showVerificationIcon,
          biddingAccepted: biddingAccepted,
          productQuantity: productQuantity!
        ));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.withOpacity(0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(8),
              backgroundColor: Colors.white,
              child: Stack(
                children: [
                  Center(
                    child: ZRoundedImage(
                      imageUrl: imageUrl ?? "",
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ZProductTitleText(
                    title: title ?? "",
                    smallSize: true,
                  ),
                  const SizedBox(height: 12),
                  ZBrandTitleWithVerification(
                    title: description ?? "",
                    showVerificationButton: showVerificationIcon,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ZProductPriceText(
                      price: price ?? "",
                      isLarge: true,
                      currencySign: "Rs ",
                    ),
                  ),
                ),
                if (showAddToCartButton)
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            biddingAccepted ? Colors.green : Color(0xffffe2a9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: SizedBox(
                        height: 38.4,
                        width: 38.4,
                        child: Icon(
                          biddingAccepted ? Iconsax.add : Icons.insights,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (removeToCart)
                  InkWell(
                    onTap: onTap,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: const SizedBox(
                        height: 38.4,
                        width: 38.4,
                        child: Icon(
                          Icons.remove_shopping_cart_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ZRoundedContainer extends StatelessWidget {
  const ZRoundedContainer(
      {super.key,
      this.height,
      this.width,
      this.radius = 12,
      this.child,
      this.showBorder = false,
      this.borderColor = Colors.grey,
      this.backgroundColor = Colors.white,
      this.padding,
      this.margin});

  final double? height;
  final double? width;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}

class ZRoundedImage extends StatelessWidget {
  const ZRoundedImage({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.margin = const EdgeInsets.all(10),
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 16,
  });

  final double? height, width;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        // padding: margin,
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
            fit: fit,
            image: isNetworkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}

class ZCircularIcon extends StatelessWidget {
  const ZCircularIcon({
    super.key,
    required this.icon,
    this.height,
    this.width,
    this.size = 24,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? height, width, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white.withOpacity(0.9)),
      child: IconButton(
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
        onPressed: () {},
      ),
    );
  }
}

class ZProductTitleText extends StatelessWidget {
  const ZProductTitleText(
      {super.key,
      required this.title,
      this.smallSize = false,
      this.maxLines = 2,
      this.textAlign = TextAlign.left});

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize
          ? Theme.of(context).textTheme.labelLarge
          : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

class ZProductPriceText extends StatelessWidget {
  const ZProductPriceText(
      {super.key,
      this.currencySign = '\$',
      required this.price,
      this.maxLines = 1,
      this.isLarge = false,
      this.lineThrough = false});

  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}

class ZBrandTitleWithVerification extends StatelessWidget {
  const ZBrandTitleWithVerification({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = Colors.green,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSizes.small,
    required this.showVerificationButton,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSizes;
  final bool showVerificationButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ZBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSizes,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        if (showVerificationButton)
          Icon(
            Iconsax.verify5,
            color: iconColor,
            size: 12,
          )
      ],
    );
  }
}

class ZBrandTitleText extends StatelessWidget {
  const ZBrandTitleText({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.color,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final Color? color;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        // Check which brand Size is Required and set the size
        style: brandTextSize == TextSizes.small
            ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
            : brandTextSize == TextSizes.medium
                ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
                : brandTextSize == TextSizes.large
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: color)
                    : Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: color));
  }
}
