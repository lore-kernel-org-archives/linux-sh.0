From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 01:10:49 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: remove r8a7778_init_irq()
Message-Id: <20130710011048.GJ32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738rot8yp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738rot8yp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 09, 2013 at 06:25:13PM +0900, Magnus Damm wrote:
> On Tue, Jul 9, 2013 at 5:48 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > This patch removes r8a7778_init_irq(), since no-one is using it.
> > And now, there is no reason to have r8a7778_init_irq_common().
> > r8a7778_init_irq_dt() includes it.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >>> Simon
> >
> > This patch is based on renesas-next-20130704v2 tag
> 
> Looks good to me, thanks for cleaning up things.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
