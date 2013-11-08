From: Simon Horman <horms@verge.net.au>
Date: Fri, 08 Nov 2013 07:59:41 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: Correct typo in clocks
Message-Id: <20131108075939.GK23477@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383714098-28770-1-git-send-email-horms+renesas@verge.net.au>
 <87zjpiysh4.wl%kuninori.morimoto.gx@renesas.com>
 <20131106083556.GC14694@verge.net.au>
In-Reply-To: <20131106083556.GC14694@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 06, 2013 at 05:35:58PM +0900, Simon Horman wrote:
> On Tue, Nov 05, 2013 at 10:06:20PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > > This is the r8a7790 SoC not the r8a77a4 SoC and
> > > clocks are updated in r8a7790_clock_init.  not r8a73a4_clock_init.
> 
> Ironically there is a typo in the line above.
> I'll fix that up before applying the patch.

I have queued-up the following:

From: Simon Horman <horms+renesas@verge.net.au>

ARM: shmobile: r8a7790: Correct typo in clocks

This is the r8a7790 SoC not the r8a77a4 SoC and
clocks are updated in r8a7790_clock_init not r8a73a4_clock_init.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index a64f965..fa1b477 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -77,7 +77,7 @@ static struct sh_clk_ops followparent_clk_ops = {
 };
 
 static struct clk main_clk = {
-	/* .parent will be set r8a73a4_clock_init */
+	/* .parent will be set r8a7790_clock_init */
 	.ops	= &followparent_clk_ops,
 };
 
-- 
1.8.4

