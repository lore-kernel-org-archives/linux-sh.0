From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Nov 2013 00:43:59 +0000
Subject: Re: [PATCH] RM: shmobile: lager: phy fixup needs CONFIG_PHYLIB
Message-Id: <20131101004359.GK6818@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383201098-4258-1-git-send-email-horms+renesas@verge.net.au>
 <5272CC16.3020700@cogentembedded.com>
In-Reply-To: <5272CC16.3020700@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 01, 2013 at 12:31:02AM +0300, Sergei Shtylyov wrote:
> On 10/31/2013 09:31 AM, Simon Horman wrote:
> 
> >Do not build the phy fixup unless CONFIG_PHYLIB is enabled.
> >Other than not being useful it is also not possible to compile
> 
>    s/compile/link/.
> 
> >the code under this condition as phy_register_fixup_for_id()
> >is not defined.
> 
>    Not only this function is absent...
> 
> >This problem was introduced by 48c8b96f21817aad
> >("ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup")
> 
> >Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/mach-shmobile/board-lager.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> >diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> >index 78a31b6..d1a8ddd 100644
> >--- a/arch/arm/mach-shmobile/board-lager.c
> >+++ b/arch/arm/mach-shmobile/board-lager.c
> >@@ -245,7 +245,9 @@ static void __init lager_init(void)
> >  {
> >  	lager_add_standard_devices();
> >
> >-	phy_register_fixup_for_id("r8a7790-ether-ff:01", lager_ksz8041_fixup);
> >+	if (IS_ENABLED(CONFIG_PHYLIB))
> >+		phy_register_fixup_for_id("r8a7790-ether-ff:01",
> >+					  lager_ksz8041_fixup);
> 
>    Perhaps you would consider enclosing the fixup function itself
> into #ifdef as it causes link errors as well?  Doesn't seem
> necessary as gcc probably drops it anyway but for completeness'
> sake...

My understanding of the motivation for IS_ENABLED() is to
take advantage of gcc optimising away unused code and making such
problems disappear.

With this patch in place do you still see any warnings?
