From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Apr 2013 00:45:24 +0000
Subject: Re: [PATCH 0/4 v2] ARM: shmobile: r8a7778: pinctrl support
Message-Id: <20130411004524.GF1205@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hajeka2q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hajeka2q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 10, 2013 at 12:58:47PM +0200, Laurent Pinchart wrote:
> Hi Morimoto-san,
> 
> On Wednesday 10 April 2013 02:29:37 Kuninori Morimoto wrote:
> > Hi Laurent, Simon, Magnus
> > 
> > These patches are v2 of r8a7778 pinctrl support
> > I removed [RFC] from Subject
> > 
> > These are based on
> > 
> > renesas-next-20130405v2
> >  + simon/defconfig-bockw
> >  + simon/soc-r8a7778
> >  + simon/boards-bockw
> > 
> > and Laurent's this patch
> > 
> > Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
> > Date:	Mon,  8 Apr 2013 12:05:30 +0200
> > 
> > Kuninori Morimoto (3):
> >       sh-pfc: Add r8a7778 pinmux support
> >       ARM: shmobile: r8a7778: Register PFC device
> >       ARM: shmobile: bockw: add pinctrl support
> 
> The patches look good, I just had a couple of comments on 1/3. I've acked 2/3 
> and 3/3 already from v1, could you pick up the acks and add them to v3 ? In 
> general picking Acked-by, Reviewed-by and Tested-by lines from the list when 
> submitting a new version is a good idea, as it helps reviewer skip patches 
> they have already reviewed.

It also helps the maintainer not to forget to add them :^)
