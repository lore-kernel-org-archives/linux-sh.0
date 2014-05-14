From: Simon Horman <horms@verge.net.au>
Date: Wed, 14 May 2014 23:05:33 +0000
Subject: Re: [PATCH 00/03] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <20140514230532.GB29233@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507231748.29661.46207.sendpatchset@w520>
In-Reply-To: <20140507231748.29661.46207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 14, 2014 at 11:00:22AM +0200, Geert Uytterhoeven wrote:
> Hi Laurent, Simon,
> 
> On Wed, May 14, 2014 at 5:23 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Wednesday 14 May 2014 12:08:32 Simon Horman wrote:
> > [snip]
> >
> >> I got a little ahead of myself there.
> >>
> >> I'm not sure how to compile (and boot) a multiplaform kernel for Armadillo.
> >> Do I need some patches which aren't in the renesas devel branch?
> >
> > You most probably do, and I expect those patches to be in Magnus' tree :-)
> 
> Yes. You need at least Ulrich's CCF patches.
> And some extras (e.g. to hook it up into multi-platform) that AFAIK have
> never been posted to the list.

Ok, I checked my git-over-telepathy skills this morning but I drew a blank.

Would it be possible for someone with all the pieces (assuming
there is someone) to either:

* Send a series or make a branch with them all present or;
* Test this series
