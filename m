From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 28 Apr 2009 08:49:03 +0000
Subject: Re: [PATCH] sh: pass through ioremap() for non-mmu processors
Message-Id: <20090428084903.GB15695@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 28, 2009 at 04:59:34PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch modifies the ioremap() handling for CONFIG_MMU=n.
> 
> All 32-bit SuperH processors currently go through __ioremap_mode()
> and check for IO_TRAPPED and directly mapped segments. With this
> patch we simplify the MMU less case with a pass through version of
>  __ioremap_mode() which just returns the physical address.
> 
> The effects of this is change are:
>  - fix non-MMU ioremap() of high address hardware blocks (sh7203 CMT)
>  - IO_TRAPPED is never checked for
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  arch/sh/Kconfig          |    1 +
>  arch/sh/include/asm/io.h |   13 +++++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> --- 0001/arch/sh/Kconfig
> +++ work/arch/sh/Kconfig	2009-04-21 15:54:59.000000000 +0900
> @@ -136,6 +136,7 @@ config ARCH_HAS_DEFAULT_IDLE
>  
>  config IO_TRAPPED
>  	bool
> +	depends on MMU
>  
You have failed at Kconfig. select trumps depends, so this has no impact
for platforms that select IO_TRAPPED. You will have to switch the
platforms that select this over to handling the dependency properly on
their own.
