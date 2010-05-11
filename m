From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:37:05 +0000
Subject: [PATCH 14/15] sh: switch boards to clkdev
Message-Id: <20100511093705.28210.6474.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch converts the remaining board clocks
to use clkdev for lookup if needed. The unused
name and id from struct clk are also removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c   |    2 --
 arch/sh/boards/mach-highlander/setup.c |   12 +++++++++++-
 arch/sh/boards/mach-se/7724/setup.c    |    2 --
 3 files changed, 11 insertions(+), 5 deletions(-)

--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2010-05-11 18:00:17.000000000 +0900
@@ -710,8 +710,6 @@ static struct clk_ops fsimck_clk_ops = {
 };
 
 static struct clk fsimckb_clk = {
-	.name		= "fsimckb_clk",
-	.id		= -1,
 	.ops		= &fsimck_clk_ops,
 	.enable_reg	= (void __iomem *)FCLKBCR,
 	.rate		= 0, /* unknown */
--- 0001/arch/sh/boards/mach-highlander/setup.c
+++ work/arch/sh/boards/mach-highlander/setup.c	2010-05-11 18:07:01.000000000 +0900
@@ -14,6 +14,7 @@
  * for more details.
  */
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
 #include <linux/types.h>
@@ -26,6 +27,7 @@
 #include <net/ax88796.h>
 #include <asm/machvec.h>
 #include <mach/highlander.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/heartbeat.h>
 #include <asm/io.h>
@@ -326,7 +328,6 @@ static struct clk_ops ivdr_clk_ops = {
 };
 
 static struct clk ivdr_clk = {
-	.name		= "ivdr_clk",
 	.ops		= &ivdr_clk_ops,
 };
 
@@ -334,6 +335,13 @@ static struct clk *r7780rp_clocks[] = {
 	&ivdr_clk,
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("ivdr_clk", &ivdr_clk),
+};
+
 static void r7780rp_power_off(void)
 {
 	if (mach_is_r7780mp() || mach_is_r7785rp())
@@ -370,6 +378,8 @@ static void __init highlander_setup(char
 		clk_enable(clk);
 	}
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	__raw_writew(0x0000, PA_OBLED);	/* Clear LED. */
 
 	if (mach_is_r7780rp())
--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2010-05-11 18:00:40.000000000 +0900
@@ -276,8 +276,6 @@ static struct clk_ops fsimck_clk_ops = {
 };
 
 static struct clk fsimcka_clk = {
-	.name		= "fsimcka_clk",
-	.id		= -1,
 	.ops		= &fsimck_clk_ops,
 	.enable_reg	= (void __iomem *)FCLKACR,
 	.rate		= 0, /* unknown */
