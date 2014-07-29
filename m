From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Jul 2014 00:52:28 +0000
Subject: Re: [PATCH 01/12] ASoC: rsnd: fixup rsnd_gen_dma_addr() for Gen1
Message-Id: <20140729005228.GD19235@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
 <87bntqzjfw.wl%kuninori.morimoto.gx@renesas.com>
 <20140618100654.GF5099@sirena.org.uk>
 <20140728125840.GA10125@verge.net.au>
 <20140728134804.GW17528@sirena.org.uk>
In-Reply-To: <20140728134804.GW17528@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-sh@vger.kernel.org

On Mon, Jul 28, 2014 at 02:48:04PM +0100, Mark Brown wrote:
> On Mon, Jul 28, 2014 at 09:58:43PM +0900, Simon Horman wrote:
> > On Wed, Jun 18, 2014 at 11:06:54AM +0100, Mark Brown wrote:
> 
> > > > ad32d0c7b0e993433df152ae747652647eb65a27
> > > > (ASoC: rsnd: add rsnd_gen_dma_addr() for DMAC addr)
> > > > added rsnd_gen_dma_addr() to calculate DMA addr,
> 
> > > Applied, thanks.
> 
> > I guess its a little too late in the cycle and I apologise
> > for not having noticed this earlier. It seems that while
> > this problem was added in v3.16-rc1 (by the patch detailed above)
> > the fix (this patch) is not present in v3.16-rc7.
> 
> Yeah, I've got too big a backlog of fixes to actually send to Linus at
> this point.

Thanks. So long as it isn't completely lost I'm happy :)

