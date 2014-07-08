From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Jul 2014 10:10:50 +0000
Subject: Re: [PATCH 0/3] dma: rcar-audmapp: add DT support
Message-Id: <20140708101048.GA7924@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87tx7iy4ot.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tx7iy4ot.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org

Hi Morimoto-san,

in order to try and create a smoother path for changes in this area to land
I have pushed them to the rcar-audmapp-for-v3.17 branch of my renesas tree
on kernel.org. It is merged into the devel and next branches of that tree
and should appear in linux-next in the near future.

My intention is to send a pull-request for this branch once it has sat
in next for a short time. I hope that this approach is useful to all parties.

On Wed, Jun 18, 2014 at 01:58:41AM -0700, Kuninori Morimoto wrote:
> 
> Hi Vinod
> 
> These patches add DT support to Renesas Audio DMAC peri peri driver.
> 
> Kuninori Morimoto (3):
>       dma: rcar-audmapp: enable .set_slave
>       dma: rcar-audmapp: don't keep audmapp_slave_config for each channeles
>       dma: rcar-audmapp: add DT support
> 
>  .../devicetree/bindings/dma/rcar-audmapp.txt       |   30 ++++++
>  drivers/dma/sh/rcar-audmapp.c                      |  113 ++++++++++++++------
>  2 files changed, 113 insertions(+), 30 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
