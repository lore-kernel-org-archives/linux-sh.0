From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 11 Mar 2009 07:20:32 +0000
Subject: [PATCH] sh: ap325 and Migo-R use new sh_mobile_ceu_info flags
Message-Id: <uprgoplg4.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
> Paul
this patch is for linux 2.6.30

 arch/sh/boards/board-ap325rxa.c   |    4 +---
 arch/sh/boards/mach-migor/setup.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index 3bdf199..f1e8eb4 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -297,9 +297,7 @@ static struct platform_device camera_device = {
 #endif /* CONFIG_I2C */
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
-	.flags = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
-	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_DATA_ACTIVE_HIGH | SOCAM_MASTER |
-	SOCAM_DATAWIDTH_8,
+	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
 };
 
 static struct resource ceu_resources[] = {
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 6d63959..6e7cbcf 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -352,9 +352,7 @@ static int tw9910_power(struct device *dev, int mode)
 }
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
-	.flags = SOCAM_MASTER | SOCAM_DATAWIDTH_8 | SOCAM_PCLK_SAMPLE_RISING
-	| SOCAM_HSYNC_ACTIVE_HIGH | SOCAM_VSYNC_ACTIVE_HIGH
-	| SOCAM_DATA_ACTIVE_HIGH,
+	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
 };
 
 static struct resource migor_ceu_resources[] = {
-- 
1.5.6.3

