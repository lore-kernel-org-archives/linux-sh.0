From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 May 2009 10:50:56 +0000
Subject: [PATCH] sh: add mode4 pin support to sh7785 clock code
Message-Id: <20090507105056.32013.9929.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use early_param() to select mode4 configuration
for the sh7785 clock code. Without this patch
there is no board configuration code that
selects PLL multiplier (36x/72x) for sh7785.

The board code must make sure that mode4 is
setup according to the hardware configuration.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-07 16:28:24.000000000 +0900
@@ -15,6 +15,22 @@
 #include <asm/freq.h>
 #include <asm/io.h>
 
+static int mode4_pin;
+
+static int __init setup_mode4_pin(char *buf)
+{
+	if (buf) {
+		if (strstr(buf, "high"))
+			mode4_pin = 1;
+
+		if (strstr(buf, "low"))
+			mode4_pin = 0;
+	}
+
+	return 0;
+}
+early_param("mode4_pin", setup_mode4_pin);
+
 static int ifc_divisors[] = { 1, 2, 4, 6 };
 static int ufc_divisors[] = { 1, 1, 4, 6 };
 static int sfc_divisors[] = { 1, 1, 4, 6 };
@@ -26,7 +42,7 @@ static int pfc_divisors[] = { 1, 1, 1, 1
 
 static void master_clk_init(struct clk *clk)
 {
-	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
+	clk->rate *= mode4_pin ? 36 : 72;
 }
 
 static struct clk_ops sh7785_master_clk_ops = {
