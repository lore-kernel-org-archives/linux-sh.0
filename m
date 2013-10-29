From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Oct 2013 05:11:22 +0000
Subject: [off-list] Re: [PATCH 0/3] rcar-hpbdma: fixup patches for double plane
Message-Id: <20131029051121.GH20432@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

as these are dma patches shouldn't they go through (lazy) Vinod?
If so, I'll Ack them ask you to repost them on the ML.

If not, I guess I can set up a branch and see if I can get
them accepted through the arm-soc tree or elsewhere.

On Thu, Oct 17, 2013 at 05:03:54PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These are v2 of R-Car HBPDMA fixup patches
> for double plane.
> 
> Kuninori Morimoto (3):
>       rcar-hpbdma: add max transfer size
>       rcar-hpbdma: initialise plane information when halted
>       rcar-hpbdma: fixup channel busy check for double plane
> 
>  drivers/dma/sh/rcar-hpbdma.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
