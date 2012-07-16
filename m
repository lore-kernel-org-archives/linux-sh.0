From: Vinod Koul <vinod.koul@linux.intel.com>
Date: Mon, 16 Jul 2012 06:19:08 +0000
Subject: Re: [PATCH 5/7 v2] dma: sh: use an integer slave ID to improve API compatibility
Message-Id: <1342418828.1726.37.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
	 <1341484183-10757-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1341484183-10757-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2012-07-05 at 12:29 +0200, Guennadi Liakhovetski wrote:
> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> index a79f10a..4e83f3e 100644
> --- a/include/linux/sh_dma.h
> +++ b/include/linux/sh_dma.h
> @@ -27,10 +27,10 @@ struct sh_dmae_slave {
>   * a certain peripheral
>   */
>  struct sh_dmae_slave_config {
> -       unsigned int                    slave_id;
> -       dma_addr_t                      addr;
> -       u32                             chcr;
> -       char                            mid_rid;
> +       int             slave_id;
> +       dma_addr_t      addr;
> +       u32             chcr;
> +       char            mid_rid;
>  }; 
why would you want to keep your own slave_id and addr fields when they
are already provided in struct dma_slave_config. Also while at it, what
would be the use of last tow fields, what do they describe?
Would it be possible to get rid of this structure completely? At least
first two fields should go away.

-- 
~Vinod

