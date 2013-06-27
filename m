From: Simon Horman <horms@verge.net.au>
Date: Thu, 27 Jun 2013 07:02:34 +0000
Subject: Re: [PATCH v3 0/2] ARM: shmobile: r8a7790: add thermal driver support
Message-Id: <20130627070232.GA22054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372297984-9315-1-git-send-email-horms+renesas@verge.net.au>
 <871u7o2jqk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u7o2jqk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 26, 2013 at 10:41:43PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > This short series enables the thermal driver on the r8a7790 SoC
> > and thus the lager board.
> > 
> > It is based on renesas-next-20130620
> > 
> > v3
> > * Correct title of clocks patch to refer to r8a7790
> > 
> > v2
> > * Add clocks patch
> > 
> > Simon Horman (2):
> >   ARM: shmobile: r8a7790: add clocks for thermal
> >   ARM: shmobile: r8a7790: add thermal driver support
> > 
> >  arch/arm/mach-shmobile/clock-r8a7790.c |  4 ++++
> >  arch/arm/mach-shmobile/setup-r8a7790.c | 12 ++++++++++++
> >  2 files changed, 16 insertions(+)
> 
> For all patches
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued these up for v3.12 in the soc branch.
