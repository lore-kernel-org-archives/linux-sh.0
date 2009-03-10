From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Mar 2009 06:13:22 +0000
Subject: [PATCH] sh: Show sleep state with Migo-R LEDs
Message-Id: <20090310061322.22300.17508.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

If CONFIG_PM is set, let Migo-R LEDs show sleep states.
D11 will show STATUS0 and D12 PDSTATUS.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-03-04 12:43:25.000000000 +0900
@@ -450,6 +450,14 @@ static struct spi_board_info migor_spi_d
 
 static int __init migor_devices_setup(void)
 {
+
+#ifdef CONFIG_PM
+	/* Let D11 LED show STATUS0 */
+	gpio_request(GPIO_FN_STATUS0, NULL);
+
+	/* Lit D12 LED show PDSTATUS */
+	gpio_request(GPIO_FN_PDSTATUS, NULL);
+#else
 	/* Lit D11 LED */
 	gpio_request(GPIO_PTJ7, NULL);
 	gpio_direction_output(GPIO_PTJ7, 1);
@@ -459,6 +467,7 @@ static int __init migor_devices_setup(vo
 	gpio_request(GPIO_PTJ5, NULL);
 	gpio_direction_output(GPIO_PTJ5, 1);
 	gpio_export(GPIO_PTJ5, 0);
+#endif
 
 	/* SMC91C111 - Enable IRQ0, Setup CS4 for 16-bit fast access */
 	gpio_request(GPIO_FN_IRQ0, NULL);
