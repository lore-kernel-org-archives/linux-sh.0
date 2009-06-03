From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Jun 2009 08:26:40 +0000
Subject: [PATCH] sh: add AP325RXA mode pin configuration
Message-Id: <20090603082640.28419.69409.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds mode pin configuration to ap325rxa.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-06-03 16:29:41.000000000 +0900
@@ -535,6 +535,18 @@ static int __init ap325rxa_devices_setup
 }
 device_initcall(ap325rxa_devices_setup);
 
+/* Return the board specific boot mode pin configuration */
+static int ap325rxa_mode_pins(void)
+{
+	/* MD0=0, MD1=0, MD2=0: Clock Mode 0
+	 * MD3=0: 16-bit Area0 Bus Width
+	 * MD5=1: Little Endian
+	 * TSTMD=1, MD8=1: Test Mode Disabled
+	 */
+	return MODE_PIN5 | MODE_PIN8;
+}
+
 static struct sh_machine_vector mv_ap325rxa __initmv = {
 	.mv_name = "AP-325RXA",
+	.mv_mode_pins = ap325rxa_mode_pins,
 };
