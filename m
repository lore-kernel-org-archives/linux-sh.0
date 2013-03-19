From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Mar 2013 04:20:54 +0000
Subject: Re: [PATCH 3/3 v2] ARM: shmobile: add R-Car M1A Bock-W platform support
Message-Id: <20130319042053.GF21444@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2v5rpck.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2v5rpck.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 14, 2013 at 01:55:47AM -0700, Kuninori Morimoto wrote:
> 
> Hi Sergei
> 
> > > +/ {
> > > +	model = "bockw";
> > > +	compatible = "renesas,bockw", "renesas,r8a7778";
> > 
> >     Shouldn't the above coincide with the below?
> (snip)
> > > +static const char *bockw_boards_compat_dt[] __initdata = {
> > > +	"renesas,bockw-reference",
> > > +	NULL,
> > > +};
> 
> Thank you for pointing it.
> It will be fixed in v2

This is v2 :^)
