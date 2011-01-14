From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Jan 2011 07:06:55 +0000
Subject: Re: [PATCH] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <AANLkTinUGCUr7XHDHycK_P0uQPObqer+xZW+-Pr5+BKY@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110110230549.GA20886@verge.net.au>
In-Reply-To: <20110110230549.GA20886@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Jan 14, 2011 at 10:29 AM, Simon Horman <horms@verge.net.au> wrote:
> Drat. There seems to be a new problem.
> I'm pretty sure it wasn't there when I checked against
> Linus's tree a few days ago. But in any case it is there now.
>
> arch/arm/boot/compressed/mmcif-sh7372.o: In function `mmcif_loader':
> mmcif-sh7372.c:(.text+0x9e8): undefined reference to `outer_cache
>
> As per
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?idb75/1,
> my suggested fix is:
>
> diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
> index bf17350..1a6eb3f 100644
> --- a/include/linux/mmc/sh_mmcif.h
> +++ b/include/linux/mmc/sh_mmcif.h
> @@ -99,7 +99,7 @@ static inline u32 sh_mmcif_readl(void __iomem *addr, in=
t reg)
>
> =A0static inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 va=
l)
> =A0{
> - =A0 =A0 =A0 writel(val, addr + reg);
> + =A0 =A0 =A0 __raw_writel(val, addr + reg);
> =A0}

You probably want to update sh_mmcif_read() as well for code consistency!

/ magnus
