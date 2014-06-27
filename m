From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Jun 2014 23:51:15 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fixup GPIO6/7 register address
Message-Id: <20140627235113.GA27128@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4wko5rp.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 26, 2014 at 04:10:19AM -0700, Kuninori Morimoto wrote:
> 
> Hi Geert
> 
> > > Sorry, I didn't.
> > > I just checked latest datasheet (H2/M2).
> > > I'm asking correct address to HW team.
> > > Please wait.
> > 
> > Thanks!
> > 
> > P.S. In case something needs to be changed: the GPIO base addresses are
> >      also in arch/arm/mach-shmobile/setup-r8a7791.c.
> 
> According to HW team,
> latest datasheet address was degraded.
> I'm so sorry, this patch is not needed.

Thanks for following up.
I will not queue up this patch.
