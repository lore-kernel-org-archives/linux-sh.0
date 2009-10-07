From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 Oct 2009 09:00:06 +0000
Subject: [PATCH] sh: enable sleep state LEDs on Ecovec24
Message-Id: <20091007090006.13079.78010.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the ecovec24 board code to enable Power
Management LEDs showing the current sh7724 sleep state.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-10-07 15:05:31.000000000 +0900
@@ -460,6 +460,11 @@ static void __init sh_eth_init(void)
 #define IODRIVEA  0xA405018A
 static int __init arch_setup(void)
 {
+	/* enable STATUS0, STATUS2 and PDSTATUS */
+	gpio_request(GPIO_FN_STATUS0, NULL);
+	gpio_request(GPIO_FN_STATUS2, NULL);
+	gpio_request(GPIO_FN_PDSTATUS, NULL);
+
 	/* enable SCIFA0 */
 	gpio_request(GPIO_FN_SCIF0_TXD, NULL);
 	gpio_request(GPIO_FN_SCIF0_RXD, NULL);
