From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Apr 2010 06:16:25 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: intc-sh7372: modify wrong address
Message-Id: <ufx2zyj0o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/mach-shmobile/intc-sh7372.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
index 3ce9d9b..cfba59f 100644
--- a/arch/arm/mach-shmobile/intc-sh7372.c
+++ b/arch/arm/mach-shmobile/intc-sh7372.c
@@ -319,17 +319,17 @@ static struct intc_prio_reg intca_prio_registers[] __initdata = {
 	{ 0xe6950034, 0, 16, 4, /* IPRNA3 */ { AP_ARM2, 0, 0, 0 } },
 	{ 0xe6950038, 0, 16, 4, /* IPROA3 */ { MFIS2, CPORTR2S,
 					       CMT14, CMT15 } },
-	{ 0xe694003c, 0, 16, 4, /* IPRPA3 */ { 0, 0,
+	{ 0xe695003c, 0, 16, 4, /* IPRPA3 */ { 0, 0,
 					       MMC_MMC_ERR, MMC_MMC_NOR } },
-	{ 0xe6940040, 0, 16, 4, /* IPRQA3 */ { IIC4_ALI4, IIC4_TACKI4,
+	{ 0xe6950040, 0, 16, 4, /* IPRQA3 */ { IIC4_ALI4, IIC4_TACKI4,
 					       IIC4_WAITI4, IIC4_DTEI4 } },
-	{ 0xe6940044, 0, 16, 4, /* IPRRA3 */ { IIC3_ALI3, IIC3_TACKI3,
+	{ 0xe6950044, 0, 16, 4, /* IPRRA3 */ { IIC3_ALI3, IIC3_TACKI3,
 					       IIC3_WAITI3, IIC3_DTEI3 } },
-	{ 0xe6940048, 0, 16, 4, /* IPRSA3 */ { 0/*ERI*/, 0/*RXI*/,
+	{ 0xe6950048, 0, 16, 4, /* IPRSA3 */ { 0/*ERI*/, 0/*RXI*/,
 					       0/*TXI*/, 0/*TEI*/} },
-	{ 0xe694004c, 0, 16, 4, /* IPRTA3 */ { USB0_USB0I1, USB0_USB0I0,
+	{ 0xe695004c, 0, 16, 4, /* IPRTA3 */ { USB0_USB0I1, USB0_USB0I0,
 					       USB1_USB1I1, USB1_USB1I0 } },
-	{ 0xe6940050, 0, 16, 4, /* IPRUA3 */ { USBHSDMAC1_USHDMI, 0, 0, 0 } },
+	{ 0xe6950050, 0, 16, 4, /* IPRUA3 */ { USBHSDMAC1_USHDMI, 0, 0, 0 } },
 };
 
 static struct intc_sense_reg intca_sense_registers[] __initdata = {
-- 
1.6.3.3

