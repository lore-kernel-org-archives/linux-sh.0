From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Jan 2011 03:41:04 +0000
Subject: [PATCH] ARM: mach-shmobile: remove sh7367 on-chip set_irq_type()
Message-Id: <20110118034104.13007.23341.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

set_irq_type() should only be used for external IRQ pins,
so update the G3EVM board code to remove low level request.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-g3evm.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2011-01-18 12:36:15.000000000 +0900
@@ -347,7 +347,6 @@ static void __init g3evm_init(void)
 	gpio_request(GPIO_FN_IRDA_OUT, NULL);
 	gpio_request(GPIO_FN_IRDA_IN, NULL);
 	gpio_request(GPIO_FN_IRDA_FIRSEL, NULL);
-	set_irq_type(evt2irq(0x480), IRQ_TYPE_LEVEL_LOW);
 
 	sh7367_add_standard_devices();
 
