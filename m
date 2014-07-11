From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 08:31:42 +0000
Subject: Re: [PATCH 0/4] dmaengine: shdma: Register documentation
Message-Id: <20140711083142.GB22753@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1403267861-15609-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1403267861-15609-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

in order to try and create a smoother path for changes in this area to land
I have pushed them to the shdma-for-v3.17 branch of my renesas tree
on kernel.org. It is merged into the devel and next branches of that tree
and should appear in linux-next in the near future.

My intention is to send a pull-request for this branch once it has sat
in next for a short time. I hope that this approach is useful to all parties.

On Fri, Jun 20, 2014 at 02:37:37PM +0200, Geert Uytterhoeven wrote:
> This patch series adds more register documentation for shdma, and replaces
> some hardcoded numbers by defines.
> 
>   [1/4] dmaengine: shdma: Add more register documentation
>   [2/4] ARM: shmobile: dma: Use defines instead of hardcoded numbers
>   [3/4] sh: dma: Use defines instead of hardcoded numbers
>   [4/4] dmaengine: shdma: Use defines instead of hardcoded numbers
> 
>  arch/arm/mach-shmobile/dma-register.h  |  4 +--
>  arch/sh/drivers/dma/dma-sh.c           |  2 +-
>  arch/sh/include/asm/dma-register.h     | 36 ++++++++++---------
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c | 24 ++++++-------
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 48 ++++++++++++-------------
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c | 64 +++++++++++++++++-----------------
>  drivers/dma/sh/shdma-arm.h             |  4 +--
>  drivers/dma/sh/shdmac.c                | 15 ++++----
>  include/linux/sh_dma.h                 | 24 +++++++------
>  9 files changed, 112 insertions(+), 109 deletions(-)
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
