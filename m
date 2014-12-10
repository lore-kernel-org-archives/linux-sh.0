From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Dec 2014 02:41:01 +0000
Subject: Re: [PATCH 11/12 v2] ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
Message-Id: <20141210024056.GA24477@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9yl2ie3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87h9yl2ie3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 10, 2014 at 12:58:42AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Is it possible to revert this patch from defconfig ?
> > > Current upstreamed Audio DMAC peri peri driver is based on SH_DMAE_BASE,
> > > but, it breaks DMAEngine handling.
> > > 
> > > I fix-uped this issue on below patch, but it is not yet accepted.
> > > 
> > > 	Subject: [PATCH][resend] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
> > > 	Date: Fri, 28 Nov 2014 00:17:59 +0000
> > > 
> > > Above patches need this order
> > > [1/2] : dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
> > > [2/2] : ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
> > > 
> > > It seems that I2C driver is broken by this patch.
> > > I will re-send it if missing DMAEngine patch was accepted.
> > 
> > Hi Morimoto-san,
> > 
> > I believe this patch is not present in v3.18 (good) but has been accepted
> > by the ARM SoC maintainers for v3.19 (not so good).  In other words its
> > present in arm-soc/for-next and linux-next but not Linus's tree
> > (but may be soon).
> > 
> > Would you like me to submit a reversion of a fix-for-v3.19 to the ARM SoC
> > maintainers?
> 
> Thank you for your help
> It depends on RCAR-DMAC enable/disable and driver (which want to use DMAEngine).
> But, unfortunately, reverting it from v3.19 is very safety. 

Thanks, I think I understand.

I plan to queue-up the following:

From: Simon Horman <horms+renesas@verge.net.au>

[PATCH] Revert "ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig"

This reverts commit 2315f9fce4da7df9362e4baeb5250d14ea48bf63.

Unfortunately enabling RCAR_AUDMAC_PP support this patch breaks dmaengine
support on R-Car Gen2 boards. This should be resolved by driver updates
in v3.20. But v3.19 was too early for this defconfig change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index cc67508..302faab 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -147,7 +147,6 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
-CONFIG_RCAR_AUDMAC_PP=y
 CONFIG_RCAR_DMAC=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
-- 
2.1.3

