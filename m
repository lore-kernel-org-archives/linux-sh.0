From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 17 Apr 2013 10:34:03 +0000
Subject: [PATCH v2 3/6] ARM: shmobile: r8a7740: Add I2C DT clock names
Message-Id: <1366194847-9879-3-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add clock association for i2c0 and i2c1 for the new DT names.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: same

 arch/arm/mach-shmobile/clock-r8a7740.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 5bd8da0..633307d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -551,6 +551,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_tmu.4",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("sh_tmu.5",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0",	&mstp_clks[MSTP116]),
+	CLKDEV_DEV_ID("fff20000.i2c",		&mstp_clks[MSTP116]),
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1",	&mstp_clks[MSTP117]),
 	CLKDEV_DEV_ID("sh_tmu.0",		&mstp_clks[MSTP125]),
 	CLKDEV_DEV_ID("sh_tmu.1",		&mstp_clks[MSTP125]),
@@ -584,6 +585,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
+	CLKDEV_DEV_ID("e6c20000.i2c",		&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("e6850000.sdhi",          &mstp_clks[MSTP314]),
-- 
1.7.9.5

