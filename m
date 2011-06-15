From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 15 Jun 2011 07:30:33 +0000
Subject: Re: [PATCH 4/5] dmaengine: shdma: tidyup parameter change method on
Message-Id: <Pine.LNX.4.64.1106150912250.23363@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pboxz62q4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pboxz62q4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 15 Jun 2011, Kuninori Morimoto wrote:

> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  drivers/dma/shdma.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
> index f7b3c06..19fd18d 100644
> --- a/drivers/dma/shdma.c
> +++ b/drivers/dma/shdma.c
> @@ -169,8 +169,9 @@ static void dmae_start(struct sh_dmae_chan *sh_chan)
>  {
>  	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
>  
> +	chcr &= ~CHCR_TE;
>  	chcr |= CHCR_DE | CHCR_IE;
> -	sh_dmae_writel(sh_chan, chcr & ~CHCR_TE, CHCR);
> +	sh_dmae_writel(sh_chan, chcr, CHCR);
>  }

Sorry, don't see any improvement here. The compiler will probably do the 
right thing for you and produce the same code, but strictly speaking 
you're asking it to do one more memory access - to store the result of 
your operation in the variable back on stack, instead of just keeping it 
in a register. On the contrary, you could even do

 	u32 chcr = sh_dmae_readl(sh_chan, CHCR) & ~CHCR_TE;

	sh_dmae_writel(sh_chan, chcr | CHCR_DE | CHCR_IE, CHCR);

to explicitly ask the compiler to avoid doing any unnecessary memory 
writes (we don't want to go the exaggerated "register" path;)).

>  
>  static void dmae_halt(struct sh_dmae_chan *sh_chan)
> -- 
> 1.7.4.1

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
