From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 24 Jun 2012 20:12:06 +0000
Subject: Re: [PATCH] PM / shmobile: sh7372: remove unused sh7372_a3sp_init() on !CONFIG_PM
Message-Id: <201206242212.06999.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9zwt15h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9zwt15h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Saturday, June 23, 2012, Simon Horman wrote:
> On Thu, Jun 21, 2012 at 09:34:54PM -0700, Kuninori Morimoto wrote:
> > 767c0f3aed74be56f268709f5347e6c86d52b408
> > (PM / shmobile: Remove the stay_on flag from SH7372's PM domains)
> > commit removed sh7372_a3sp_init().
> > Now, there is no user for it.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>

Applied to the sh7372 branch of the renesas.git tree.

Thanks,
Rafael


> > ---
> >  arch/arm/mach-shmobile/pm-sh7372.c |    7 +------
> >  1 files changed, 1 insertions(+), 6 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

