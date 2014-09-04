From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Sep 2014 04:25:08 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Cleanup PM Kconfig usage
Message-Id: <20140904042504.GA25226@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904033942.22881.84361.sendpatchset@w520>
In-Reply-To: <20140904033942.22881.84361.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 04, 2014 at 01:17:54PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Sep 4, 2014 at 1:12 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 04, 2014 at 12:39:42PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Simplify the r8a7740 PM code by using CONFIG_PM_RMOBILE instead
> >> of having a complex #if expression embedded in the C code.
> >>
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >
> > Thanks Magnus,
> >
> > this looks good to me.
> >
> > The dependencies for this changes are a bit messy so I would like
> > to defer it until v3.19. Could you repost it once v3.18-rc6 is released?
> 
> Sure, will do! Does that apply to this patch only, or also to other
> things like the new (sh73a0 and/or r8a73a4) multiplatform bits and
> legacy board code removal?

At this time I would like to handle-things on a case-by-case basis.

In general it would make my life slightly easier if all futher
cleanups were deferred until v3.19. But at this stage I'm still happy
to assess each patch on its merits.
