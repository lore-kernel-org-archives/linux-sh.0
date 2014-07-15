From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Jul 2014 09:02:07 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: dma: Use defines instead of hardcoded numbers
Message-Id: <20140715090207.GE17806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1403267861-15609-1-git-send-email-geert+renesas@glider.be>
 <1403267861-15609-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1403267861-15609-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 20, 2014 at 02:37:39PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/mach-shmobile/dma-register.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/dma-register.h b/arch/arm/mach-shmobile/dma-register.h
> index 97c40bd9b94f..52a2f66e600f 100644
> --- a/arch/arm/mach-shmobile/dma-register.h
> +++ b/arch/arm/mach-shmobile/dma-register.h
> @@ -52,8 +52,8 @@ static const unsigned int dma_ts_shift[] = {
>  	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
>  	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
>  
> -#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
> -#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
> +#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | RS_ERS | TS_INDEX2VAL((xmit_sz)))
> +#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | RS_ERS | TS_INDEX2VAL((xmit_sz)))

I am dropping this patch from the shdma-for-v3.17 branch (which I am
preparing for Vinod) as it depends on a patch in another branch of my tree
(which I am preparing for arm-SoC).

Could you please repost this patch once the other patches
in this tree have been accepted by Vinod.

Thanks
