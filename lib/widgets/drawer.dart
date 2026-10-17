Container(
  child: TextButton.icon(
    style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white70)),
        alignment: Alignment.centerLeft,
        minimumSize: MaterialStateProperty.all(const Size(200, 50))),
    icon: const Icon(
      Icons.account_box_outlined,
      color: Colors.white70,
    ),
    label: Text(
      S.of(context).privacyPolicy,
      style: TextStyle(
        color: Colors.white70,
      ),
    ),
    onPressed: () {
      Constant.isClickAgreement = false;
      Get.toNamed(
          '${RouteConfig.webPage}?title=${S.of(context).privacyPolicy}&url=${Constant.privacyUrl}');
    },
  ),
),
