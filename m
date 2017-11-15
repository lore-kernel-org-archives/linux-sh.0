From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Wed, 15 Nov 2017 10:55:59 +0000
Subject: [PATCH v1 06/10] sh: sh7722: Rename CEU clock
Message-Id: <1510743363-25798-7-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1510743363-25798-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, mchehab@kernel.org, hverkuil@xs4all.nl
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Rename CEU clock to match the new platform driver name used in Migo-R.

There are no other sh7722 based devices Migo-R apart, so we can safely
rename this.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 8f07a1a..d85091e 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -223,7 +223,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
 	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU]),
-	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[HWBLK_CEU]),
+	CLKDEV_DEV_ID("renesas-ceu.0", &mstp_clks[HWBLK_CEU]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU]),
 	CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[HWBLK_LCDC]),
-- 
2.7.4

