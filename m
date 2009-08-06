From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 15:03:43 +0000
Subject: [PATCH] sh: LED9, LED10 and LED11 support for Solution Engine 7724
Message-Id: <20090806150343.4770.1714.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds support for LED9, LED10 and LED11 on
the Solution Engine 7724 board. If CONFIG_PM is enabled
then these LEDs are used to show the hardware sleep
mode used by the processor. Useful to debug cpuidle.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7724/setup.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-08-05 15:22:48.000000000 +0900
@@ -429,6 +429,32 @@ static int __init devices_setup(void)
 	/* turn on USB clocks, use external clock */
 	ctrl_outw((ctrl_inw(PORT_MSELCRB) & ~0xc000) | 0x8000, PORT_MSELCRB);
 
+#ifdef CONFIG_PM
+	/* Let LED9 show STATUS2 */
+	gpio_request(GPIO_FN_STATUS2, NULL);
+
+	/* Lit LED10 show STATUS0 */
+	gpio_request(GPIO_FN_STATUS0, NULL);
+
+	/* Lit LED11 show PDSTATUS */
+	gpio_request(GPIO_FN_PDSTATUS, NULL);
+#else
+	/* Lit LED9 */
+	gpio_request(GPIO_PTJ6, NULL);
+	gpio_direction_output(GPIO_PTJ6, 1);
+	gpio_export(GPIO_PTJ6, 0);
+
+	/* Lit LED10 */
+	gpio_request(GPIO_PTJ5, NULL);
+	gpio_direction_output(GPIO_PTJ5, 1);
+	gpio_export(GPIO_PTJ5, 0);
+
+	/* Lit LED11 */
+	gpio_request(GPIO_PTJ7, NULL);
+	gpio_direction_output(GPIO_PTJ7, 1);
+	gpio_export(GPIO_PTJ7, 0);
+#endif
+
 	/* enable USB0 port */
 	ctrl_outw(0x0600, 0xa40501d4);
 
