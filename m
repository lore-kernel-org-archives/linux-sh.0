From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Jun 2009 08:22:50 +0000
Subject: [PATCH] sh: add Migo-R mode pin configuration
Message-Id: <20090603082250.28379.68248.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds mode pin configuration and
a machvec structure to Migo-R.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-06-03 16:38:01.000000000 +0900
@@ -584,3 +584,22 @@ static int __init migor_devices_setup(vo
 	return platform_add_devices(migor_devices, ARRAY_SIZE(migor_devices));
 }
 __initcall(migor_devices_setup);
+
+/* Return the board specific boot mode pin configuration */
+static int migor_mode_pins(void)
+{
+	/* MD0=1, MD1=1, MD2=0: Clock Mode 3
+	 * MD3=0: 16-bit Area0 Bus Width
+	 * MD5=1: Little Endian
+	 * TSTMD=1, MD8=0: Test Mode Disabled
+	 */
+	return MODE_PIN0 | MODE_PIN1 | MODE_PIN5;
+}
+
+/*
+ * The Machine Vector
+ */
+static struct sh_machine_vector mv_migor __initmv = {
+	.mv_name		= "Migo-R",
+	.mv_mode_pins		= migor_mode_pins,
+};
