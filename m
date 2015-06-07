From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Sun, 07 Jun 2015 08:57:55 +0000
Subject: [PATCHv2 01/11] clock-sh7724.c: fix sh-vou clock identifier
Message-Id: <1433667485-35711-2-git-send-email-hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1433667485-35711-1-git-send-email-hverkuil@xs4all.nl>
In-Reply-To: <1433667485-35711-1-git-send-email-hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>, Magnus Damm <damm@opensource.se>

From: Hans Verkuil <hans.verkuil@cisco.com>

Bitrot has set in for this driver and the sh-vou clock was never enabled,
since the clock name in clock-sh7724.c was wrong. It should be sh-vou, not
sh-vou.0.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Thanks-to: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index c187b95..f27c618 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -343,7 +343,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("2ddmac0", &mstp_clks[HWBLK_2DDMAC]),
 	CLKDEV_DEV_ID("sh_fsi.0", &mstp_clks[HWBLK_SPU]),
 	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
-	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_DEV_ID("sh-vou", &mstp_clks[HWBLK_VOU]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU0]),
 	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[HWBLK_CEU0]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU0]),
-- 
2.1.4

