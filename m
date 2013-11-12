From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 12 Nov 2013 05:03:05 +0000
Subject: Re: [PATCH 0/3] rcar-hpbdma: fixup patches for double plane
Message-Id: <20131112045105.GG8834@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3hc189h.wl%kuninori.morimoto.gx@renesas.com>
 <87eh747eoj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eh747eoj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Max Filippov <max.filippov@cogentembedded.com>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-kernel@vger.kernel.org

On Mon, Oct 28, 2013 at 11:51:28PM -0700, Kuninori Morimoto wrote:
> 
> Hi Vinod
> Cc: Simon, Max
> 
> These patches fixup R-Car HBPDMA driver
> for double plane.
> 
> I tested these patches on my R-Car sound driver in local environment.
> It doesn't work without these patches.
Applied, thanks

--
~Vinod

> 
> Kuninori Morimoto (3):
>       rcar-hpbdma: add max transfer size
>       rcar-hpbdma: initialise plane information when halted
>       rcar-hpbdma: fixup channel busy check for double plane
> 
>  drivers/dma/sh/rcar-hpbdma.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> 
> Best regards
> ---
> Kuninori Morimoto

-- 
