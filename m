From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 14 Apr 2014 01:41:37 +0000
Subject: [PATCH v2 repost 1/2] ARM: shmobile: r8a7779: Use clks as MSTP007 parent
Message-Id: <1397439698-30123-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1397439698-30123-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1397439698-30123-1-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

According to the documentation the parent clock of
MSTP007 should be clks not clkp.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v2
* First post, as suggested by Laurent Pinchart
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 2009a9b..9989b1b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -170,7 +170,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP010] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 10, 0), /* SSI2 */
 	[MSTP009] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  9, 0), /* SSI3 */
 	[MSTP008] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  8, 0), /* SRU */
-	[MSTP007] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  7, 0), /* HSPI */
+	[MSTP007] = SH_CLK_MSTP32(&s_clk, MSTPCR0,  7, 0), /* HSPI */
 };
 
 static struct clk_lookup lookups[] = {
-- 
1.8.5.2

