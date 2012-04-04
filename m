From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Apr 2012 06:06:08 +0000
Subject: Re: [PATCH resend 2/2] ARM: mach-shmobile: mackerel: Add FSI DMAEngine support
Message-Id: <20120404060607.GC8071@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjgm9ais.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjgm9ais.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 03, 2012 at 10:49:12PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > >  arch/arm/mach-shmobile/board-mackerel.c |    8 ++++++--
> > >  1 files changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> > > index 13ba0ac..ff73e5a 100644
> > > --- a/arch/arm/mach-shmobile/board-mackerel.c
> > > +++ b/arch/arm/mach-shmobile/board-mackerel.c
> > > @@ -922,6 +922,8 @@ fsi_set_rate_end:
> > >  static struct sh_fsi_platform_info fsi_info = {
> > >  	.port_a = {
> > >  		.flags = SH_FSI_BRS_INV,
> > > +		.tx_id = SHDMA_SLAVE_FSIA_TX,
> > > +		.rx_id = SHDMA_SLAVE_FSIA_RX,
> > >  	},
> > >  	.port_b = {
> > >  		.flags = SH_FSI_BRS_INV	|
> > 
> > Which tree does this apply to or is there a dependency?
> > I'm having trouble with the above hunk both on v3.3 and
> > the soc branch of Rafael's renesas tree.
> 
> It is for latest linus/master tree.

Thanks, I now have the patches applied against linus/master.
