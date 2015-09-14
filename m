From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:14:24 +0000
Subject: [PATCH 02/14] sh: Rename sci_ick and sci_fck clock to fck
Message-Id: <1442232876-27629-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SCI driver requires a functional clock named "fck" and falls back to
"sci_ick" or "sci_fck" when the "fck" clock doesn't exist. To allow
removal of the fallback code rename the sci_ick and sci_fck clocks to
fck for all SH platforms.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c |  9 ++++++++-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c | 16 ++++++++--------
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |  8 ++++----
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |  6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |  6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c | 12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |  8 ++++----
 10 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
index 8638fba6cd7f..7e06e39b0958 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
@@ -115,7 +115,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
 
 	/* MSTP clocks */
-	CLKDEV_CON_ID("sci_ick", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.4", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.5", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.6", &mstp_clks[MSTP77]),
+	CLKDEV_ICK_ID("fck", "sh-sci.7", &mstp_clks[MSTP77]),
 	CLKDEV_CON_ID("vdc3", &mstp_clks[MSTP74]),
 	CLKDEV_ICK_ID("fck", "sh-cmt-16.0", &mstp_clks[MSTP72]),
 	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP60]),
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7269.c b/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
index f8a5c2abdfb3..663a97bed554 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
@@ -150,14 +150,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("bus_clk", &div4_clks[DIV4_B]),
 
 	/* MSTP clocks */
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP47]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP46]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP45]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP44]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP43]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP47]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP46]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP45]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP44]),
+	CLKDEV_ICK_ID("fck", "sh-sci.4", &mstp_clks[MSTP43]),
+	CLKDEV_ICK_ID("fck", "sh-sci.5", &mstp_clks[MSTP42]),
+	CLKDEV_ICK_ID("fck", "sh-sci.6", &mstp_clks[MSTP41]),
+	CLKDEV_ICK_ID("fck", "sh-sci.7", &mstp_clks[MSTP40]),
 	CLKDEV_ICK_ID("fck", "sh-cmt-16.0", &mstp_clks[MSTP72]),
 	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP60]),
 	CLKDEV_ICK_ID("fck", "sh-mtu2", &mstp_clks[MSTP35]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index 9edc06c02dcf..a907ee2388bf 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -232,10 +232,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("mfi0", &mstp_clks[MSTP011]),
 	CLKDEV_CON_ID("flctl0", &mstp_clks[MSTP010]),
 
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP007]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP006]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP005]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP004]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP007]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP006]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP005]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP004]),
 
 	CLKDEV_CON_ID("sio0", &mstp_clks[MSTP003]),
 	CLKDEV_CON_ID("siof0", &mstp_clks[MSTP002]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 955b9add7810..ac9854179dee 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -230,9 +230,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("mfi0", &mstp_clks[MSTP011]),
 	CLKDEV_CON_ID("flctl0", &mstp_clks[MSTP010]),
 
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP007]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP006]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP005]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP007]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP006]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP005]),
 
 	CLKDEV_CON_ID("msiof0", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("sbr0", &mstp_clks[MSTP001]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index ccbcab550df2..fe844222f3f6 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -267,12 +267,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[HWBLK_TMU0]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[HWBLK_TMU1]),
 
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[HWBLK_SCIF3]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[HWBLK_SCIF4]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[HWBLK_SCIF5]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[HWBLK_SCIF3]),
+	CLKDEV_ICK_ID("fck", "sh-sci.4", &mstp_clks[HWBLK_SCIF4]),
+	CLKDEV_ICK_ID("fck", "sh-sci.5", &mstp_clks[HWBLK_SCIF5]),
 
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[HWBLK_LCDC]),
 };
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
index 7f54bf2f453d..354dcac5e4cd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
@@ -194,12 +194,12 @@ static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh7734.0", &mstp_clks[MSTP030]),
 	CLKDEV_DEV_ID("i2c-sh7734.1", &mstp_clks[MSTP029]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP026]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP024]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP023]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP022]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP021]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP024]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP023]),
+	CLKDEV_ICK_ID("fck", "sh-sci.4", &mstp_clks[MSTP022]),
+	CLKDEV_ICK_ID("fck", "sh-sci.5", &mstp_clks[MSTP021]),
 	CLKDEV_CON_ID("hscif", &mstp_clks[MSTP019]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP016]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[MSTP015]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index e40ec2c97ad1..b10af2ae9f35 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -125,9 +125,9 @@ static struct clk_lookup lookups[] = {
 
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP113]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[MSTP114]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP112]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP111]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP110]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP112]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP111]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP110]),
 
 	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP103]),
 	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP102]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index 8eb6e62340c9..1aafd5496752 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -132,12 +132,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP32 clocks */
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP029]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP028]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP027]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP026]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP024]),
+	CLKDEV_ICK_ID("fck", "sh-sci.5", &mstp_clks[MSTP029]),
+	CLKDEV_ICK_ID("fck", "sh-sci.4", &mstp_clks[MSTP028]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP027]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP024]),
 
 	CLKDEV_CON_ID("ssi1_fck", &mstp_clks[MSTP021]),
 	CLKDEV_CON_ID("ssi0_fck", &mstp_clks[MSTP020]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 5e50e7ebeff0..ac3dcfe5d303 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -139,12 +139,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP32 clocks */
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP029]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP028]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP027]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP026]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP024]),
+	CLKDEV_ICK_ID("fck", "sh-sci.5", &mstp_clks[MSTP029]),
+	CLKDEV_ICK_ID("fck", "sh-sci.4", &mstp_clks[MSTP028]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP027]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP024]),
 
 	CLKDEV_CON_ID("ssi3_fck", &mstp_clks[MSTP023]),
 	CLKDEV_CON_ID("ssi2_fck", &mstp_clks[MSTP022]),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index 605221d1448a..b1bdbc3cbc21 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -114,10 +114,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP32 clocks */
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP027]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP026]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP024]),
+	CLKDEV_ICK_ID("fck", "sh-sci.3", &mstp_clks[MSTP027]),
+	CLKDEV_ICK_ID("fck", "sh-sci.2", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("fck", "sh-sci.0", &mstp_clks[MSTP024]),
 
 	CLKDEV_CON_ID("h8ex_fck", &mstp_clks[MSTP003]),
 	CLKDEV_CON_ID("csm_fck", &mstp_clks[MSTP002]),
-- 
2.4.6

