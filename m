From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Apr 2012 05:49:12 +0000
Subject: Re: [PATCH resend 2/2] ARM: mach-shmobile: mackerel: Add FSI DMAEngine support
Message-Id: <87sjgkhwru.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjgm9ais.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjgm9ais.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/mach-shmobile/board-mackerel.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> > index 13ba0ac..ff73e5a 100644
> > --- a/arch/arm/mach-shmobile/board-mackerel.c
> > +++ b/arch/arm/mach-shmobile/board-mackerel.c
> > @@ -922,6 +922,8 @@ fsi_set_rate_end:
> >  static struct sh_fsi_platform_info fsi_info = {
> >  	.port_a = {
> >  		.flags = SH_FSI_BRS_INV,
> > +		.tx_id = SHDMA_SLAVE_FSIA_TX,
> > +		.rx_id = SHDMA_SLAVE_FSIA_RX,
> >  	},
> >  	.port_b = {
> >  		.flags = SH_FSI_BRS_INV	|
> 
> Which tree does this apply to or is there a dependency?
> I'm having trouble with the above hunk both on v3.3 and
> the soc branch of Rafael's renesas tree.

It is for latest linus/master tree.
Does your branch has this commit ?

-------------------
commit 7da9ced6066c654a22836c24bae509ef323e10a8
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Fri Feb 3 00:59:33 2012 -0800

    ASoC: fsi: Add DMAEngine support
    
    This patch supports DMAEngine to FSI driver.
    It supports only Tx case at this point.
    If platform/cpu doesn't support DMAEngine, FSI driver will
    use PIO transfer.
    
-------------------

Best regards
---
Kuninori Morimoto
