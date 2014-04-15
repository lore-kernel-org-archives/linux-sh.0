From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:45:22 +0000
Subject: [PATCH 3/5] [DEBUG] sh/cpg: Monitor MSTP clock enable/disable
Message-Id: <1397565924-23541-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/sh/clk/cpg.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 7442bc130055..af63bd63d4cf 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -51,8 +51,94 @@ static unsigned int r32(const void __iomem *addr)
 	return ioread32(addr);
 }
 
+#define SMSTPCR0	0xE6150130
+#define SMSTPCR1	0xE6150134
+#define SMSTPCR2	0xe6150138
+#define SMSTPCR3	0xE615013C
+#define SMSTPCR5	0xE6150144
+#define SMSTPCR7	0xe615014c
+#define SMSTPCR8	0xE6150990
+#define SMSTPCR9	0xE6150994
+#define SMSTPCR10	0xE6150998
+#define SMSTPCR11	0xE615099C
+
+unsigned int mstp_nr(const struct clk *clk)
+{
+	unsigned int base;
+	switch ((unsigned long)clk->enable_reg) {
+	case SMSTPCR0:	base = 0; break;
+	case SMSTPCR1:	base = 1; break;
+	case SMSTPCR2:	base = 2; break;
+	case SMSTPCR3:	base = 3; break;
+	case SMSTPCR5:	base = 5; break;
+	case SMSTPCR7:	base = 7; break;
+	case SMSTPCR8:	base = 8; break;
+	case SMSTPCR9:	base = 9; break;
+	case SMSTPCR10:	base = 10; break;
+	case SMSTPCR11:	base = 11; break;
+	default:		base = 1000; break;
+	}
+	return base * 100 + clk->enable_bit;
+}
+
+const char *mstp_name(unsigned int mstp)
+{
+	switch (mstp) {
+	case 931:	return "I2C0";
+	case 930:	return "I2C1";
+	case 929:	return "I2C2";
+	case 928:	return "I2C3";
+	case 927:	return "I2C4";
+	case 925:	return "I2C5";
+	case 917:	return "QSPI";
+	case 912:	return "GPIO0";
+	case 911:	return "GPIO1";
+	case 910:	return "GPIO2";
+	case 909:	return "GPIO3";
+	case 908:	return "GPIO4";
+	case 907:	return "GPIO5";
+	case 905:	return "GPIO6";
+	case 904:	return "GPIO7";
+	case 815:	return "SATA0";
+	case 814:	return "SATA1";
+	case 813:	return "Ether";
+	case 811:	return "VIN0";
+	case 810:	return "VIN1";
+	case 809:	return "VIN2";
+	case 726:	return "LVDS0";
+	case 724:	return "DU0";
+	case 723:	return "DU1";
+	case 721:	return "SCIF0";
+	case 720:	return "SCIF1";
+	case 719:	return "SCIF2";
+	case 718:	return "SCIF3";
+	case 715:	return "SCIF4";
+	case 714:	return "SCIF5";
+	case 522:	return "Thermal";
+	case 314:	return "SDHI0";
+	case 312:	return "SDHI1";
+	case 311:	return "SDHI2";
+	case 216:	return "SCIFB2";
+	case 208:	return "MSIOF1";
+	case 207:	return "SCIFB1";
+	case 206:	return "SCIFB0";
+	case 205:	return "MSIOF2";
+	case 204:	return "SCIFA0";
+	case 203:	return "SCIFA1";
+	case 202:	return "SCIFA2";
+	case 1106:	return "SCIFA3";
+	case 1107:	return "SCIFA4";
+	case 1108:	return "SCIFA5";
+	case 124:	return "CMT0";
+	case 000:	return "MSIOF0";
+	default:	return "";
+	}
+}
+
 static int sh_clk_mstp_enable(struct clk *clk)
 {
+unsigned int mstp = mstp_nr(clk);
+pr_info("MSTP %03u %s ON\n", mstp, mstp_name(mstp));
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
 		unsigned int (*read)(const void __iomem *addr);
@@ -82,6 +168,8 @@ static int sh_clk_mstp_enable(struct clk *clk)
 
 static void sh_clk_mstp_disable(struct clk *clk)
 {
+unsigned int mstp = mstp_nr(clk);
+pr_info("MSTP %03u %s OFF\n", mstp, mstp_name(mstp));
 	sh_clk_write(sh_clk_read(clk) | (1 << clk->enable_bit), clk);
 }
 
-- 
1.7.9.5

