From: Simon Horman <horms@verge.net.au>
Date: Wed, 20 Jun 2012 02:23:15 +0000
Subject: Re: [PATCH v2] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <20120620022312.GA898@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <87ehpir0rl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehpir0rl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Jun 13, 2012 at 09:11:13PM -0700, Kuninori Morimoto wrote:
> 
> Laurent Pinchart wrote:
> > 
> > The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> > width. When the mmc core requests the driver to power off the card, we
> > inform runtime PM, that the controller can be suspended. This can lead
> > to the MSTP clock being turned off.
> > 
> > Writing to any 16-bit hardware registers with the MSTP clock off leads
> > to timeouts and errors being printed to the kernel log. This can occur
> > both when stopping the MMC clock and when configuring the bus width.
> > 
> > To fix this, stop the MMC clock before calling put_runtime_pm(), and
> > skip bus width configuration when power is off.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> 
> This patch solved kzm9g MicroSD hang-up issue.
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Yes, it solves that issue for me too.

Tested-by: Simon Horman <horms@verge.net.au>


