From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 08:48:28 +0000
Subject: Re: [RFC][PATCH] sh-pfc: r8a7779: tidyup intc_irq3_b typo
Message-Id: <20130409084828.GI18478@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87obdpohxx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87obdpohxx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 08, 2013 at 11:41:05AM +0200, Laurent Pinchart wrote:
> Hi Morimoto-san,
> 
> On Sunday 07 April 2013 19:49:17 Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > 
> > >> Laurent
> > 
> > Now, I'm studying about sh pinctrol code.
> > So, I can't have firm belief about this patch.
> > But maybe it was typo
> 
> It's definitely a typo, thank you for pointing it out.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Simon, this is a bug fix, could you please push it to v3.10 ?

Sure. I have queued it up in the pinmux branch which currently contains
no other changes that aren't in arm-soc. I will send a pull request in
the not to distant future, most likely tomorrow.
