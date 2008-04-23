From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 11:24:52 +0000
Subject: [PATCH] sh: fix sh7705 interrupt vector typo
Message-Id: <20080423112452.3835.15995.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix sh7705 interrupt sources for vectors 0xc80 and 0xca0.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/setup-sh7705.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7705.c	2008-04-22 17:27:15.000000000 +0900
@@ -48,7 +48,7 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(ADC_ADI, 0x980),
 	INTC_VECT(USB_USI0, 0xa20), INTC_VECT(USB_USI1, 0xa40),
 	INTC_VECT(TPU0, 0xc00), INTC_VECT(TPU1, 0xc20),
-	INTC_VECT(TPU3, 0xc80), INTC_VECT(TPU1, 0xca0),
+	INTC_VECT(TPU2, 0xc80), INTC_VECT(TPU3, 0xca0),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
 	INTC_VECT(TMU2_TUNI, 0x440), INTC_VECT(TMU2_TICPI, 0x460),
 	INTC_VECT(RTC_ATI, 0x480), INTC_VECT(RTC_PRI, 0x4a0),
