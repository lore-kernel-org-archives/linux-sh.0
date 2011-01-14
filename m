From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 14 Jan 2011 06:49:28 +0000
Subject: Re: [PATCH] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <20110114064928.GA2122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110110230549.GA20886@verge.net.au>
In-Reply-To: <20110110230549.GA20886@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 14, 2011 at 10:29:16AM +0900, Simon Horman wrote:
> Drat. There seems to be a new problem.
> I'm pretty sure it wasn't there when I checked against
> Linus's tree a few days ago. But in any case it is there now.
> 
> arch/arm/boot/compressed/mmcif-sh7372.o: In function `mmcif_loader':
> mmcif-sh7372.c:(.text+0x9e8): undefined reference to `outer_cache
> 
This would be because some of the L2 cache handling rework that came in
from the ARM tree.

> As per
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idb75/1,
> my suggested fix is:
> 
> diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
> index bf17350..1a6eb3f 100644
> --- a/include/linux/mmc/sh_mmcif.h
> +++ b/include/linux/mmc/sh_mmcif.h
> @@ -99,7 +99,7 @@ static inline u32 sh_mmcif_readl(void __iomem *addr, int reg)
>  
>  static inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
>  {
> -	writel(val, addr + reg);
> +	__raw_writel(val, addr + reg);
>  }
>  
>  #define SH_MMCIF_BBS 512 /* boot block size */
> 
> This code is also used by SH. So I'd value an opinion on weather this
> change is valid for sh. Also on a suggested merge strategy. Paul,
> I guess this should also go through your tree.
> 
> Lastly, I don't have access to my board today, so I will have to verify
> the change tomorrow.
> 
We don't worry about writes being reordered, so that's fine for SH as
well. It doesn't particularly matter which tree the change goes through,
as I already have fixes pending in both the SH and R-Mobile branches.
I'll probably just do this through the R-Mobile branch since that's where
the breakage invariably manifests itself.
