From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 01 Nov 2012 00:11:21 +0000
Subject: Re: [PATCH 0/3] sh/ARM: shmobile: add sh_clk_fsidiv_register()
Message-Id: <20121101001119.GB24257@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87ip9rmjcb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ip9rmjcb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 31, 2012 at 03:08:26PM +0800, Simon Horman wrote:
> On Tue, Oct 30, 2012 at 08:05:59PM -0700, Kuninori Morimoto wrote:
> > 
> > Hi Paul, Simon
> > 
> > These patches add sh_clk_fsidiv_register() for FSI-DIV clock control.
> > This is 1st step of FSI-DT support.
> > My plan is...
> > 
> >  1st : sh/ARM: add FSI-DIV clock control functions
> >  2nd : FSI driver supports audio clock calculation method
> >  3rd : sh/ARM: remove old style .set_rate callback from platform
> >  4th : FSI support DT
> >  5th : platform use DT for FSI
> > 
> > Kuninori Morimoto (3):
> >       sh: clkfwk: add sh_clk_fsidiv_register()
> >       ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
> >       ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
> 
> I am slightly confused about why 4 patches, but its not a big deal.
> 
> Paul, how do you want to handle merging this?  The 1st patch looks like its
> appropriate for your tree while the rest seem to belong in my tree. But I'm
> happy for all the changes to go through one tree if that makes sense.

It's not such a big deal either way. Once the first patch has been
corrected with the appropriate I/O accessors you're welcome to take it
with the rest with my Acked-by. I don't believe we have anything on the
SH side that depends on it, so there's not a lot of point in decoupling
it from the rest of the patch set.
