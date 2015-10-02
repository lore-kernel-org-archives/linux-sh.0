From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 02 Oct 2015 23:21:15 +0000
Subject: [PATCH v3] pinctrl: sh-pfc: r8a779[01]: move 'union vin_data' to shared header file
Message-Id: <5498069.3NrXYzuRL0@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
In-Reply-To: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

R8A7790/1 PFC  drivers use almost identical  'union vin_data' and completely
identical VIN_DATA_PIN_GROUP() macro; we thus can  move them into the shared
header file...

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---
The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

Changes in version 3:
- added a comment to the common header file;
- added Laurent's ACK.

Changes in version 2:
- removed leftover empty line from the R8A7790 driver;
- added Geert's ACK.

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   19 -------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   18 ------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |   23 +++++++++++++++++++++++
 3 files changed, 23 insertions(+), 37 deletions(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3624,25 +3624,6 @@ static const unsigned int usb2_pins[]  static const unsigned int usb2_mux[] = {
 	USB2_PWEN_MARK, USB2_OVC_MARK,
 };
-
-union vin_data {
-	unsigned int data24[24];
-	unsigned int data20[20];
-	unsigned int data16[16];
-	unsigned int data12[12];
-	unsigned int data10[10];
-	unsigned int data8[8];
-	unsigned int data4[4];
-};
-
-#define VIN_DATA_PIN_GROUP(n, s)				\
-	{							\
-		.name = #n#s,					\
-		.pins = n##_pins.data##s,			\
-		.mux = n##_mux.data##s,				\
-		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
-	}
-
 /* - VIN0 ------------------------------------------------------------------- */
 static const union vin_data vin0_data_pins = {
 	.data24 = {
Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -3986,24 +3986,6 @@ static const unsigned int usb1_mux[] = {
 	USB1_PWEN_MARK,
 	USB1_OVC_MARK,
 };
-
-union vin_data {
-	unsigned int data24[24];
-	unsigned int data20[20];
-	unsigned int data16[16];
-	unsigned int data12[12];
-	unsigned int data10[10];
-	unsigned int data8[8];
-};
-
-#define VIN_DATA_PIN_GROUP(n, s)				\
-	{							\
-		.name = #n#s,					\
-		.pins = n##_pins.data##s,			\
-		.mux = n##_mux.data##s,				\
-		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
-	}
-
 /* - VIN0 ------------------------------------------------------------------- */
 static const union vin_data vin0_data_pins = {
 	.data24 = {
Index: linux-pinctrl/drivers/pinctrl/sh-pfc/sh_pfc.h
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -52,6 +52,29 @@ struct sh_pfc_pin_group {
 	unsigned int nr_pins;
 };
 
+/*
+ * Using union vin_data saves memory occupied by the VIN data pins.
+ * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups
+ * in this case.
+ */
+#define VIN_DATA_PIN_GROUP(n, s)				\
+	{							\
+		.name = #n#s,					\
+		.pins = n##_pins.data##s,			\
+		.mux = n##_mux.data##s,				\
+		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
+	}
+
+union vin_data {
+	unsigned int data24[24];
+	unsigned int data20[20];
+	unsigned int data16[16];
+	unsigned int data12[12];
+	unsigned int data10[10];
+	unsigned int data8[8];
+	unsigned int data4[4];
+};
+
 #define SH_PFC_FUNCTION(n)				\
 	{						\
 		.name = #n,				\

