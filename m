From: Simon Horman <horms@verge.net.au>
Date: Fri, 05 Apr 2013 00:26:55 +0000
Subject: Re: [ANNOUNCE] Fine grained branches
Message-Id: <20130405002652.GA29203@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130404070700.GA10022@verge.net.au>
In-Reply-To: <20130404070700.GA10022@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 04, 2013 at 01:18:08PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 04 April 2013 16:07:00 Simon Horman wrote:
> > Hi,
> > 
> > in an effort to streamline management of the renesas tree I am trying the
> > use of more fine-grained branches.
> > 
> > For the past few release there have been the following branches:
> > 
> > * defconfig
> > * boards
> > * soc
> > * pinmux
> > 
> > Some sundry branches for drivers. And merge branches that bring things
> > together. Currently next is the only merge branch I am maintaining.
> > 
> > Going forwards I plan to make per-board defconfig and boards branches and
> > per-soc pinmux and soc branches.
> 
> I wonder whether it might not be too soon for per-SoC pinmux branches. I will 
> still need to perform cross-SoC changes to the PFC driver for v3.11 to 
> implement DT support. Splitting the patches in per-SoC pinmux branches 
> wouldn't be practical, as there would likely be many cross-dependencies. The 
> situation should hopefully stabilize after v3.11.

Understood, lets keep pinmux in a single branch and see how things go.

> > So instead of applying an sh73a0 patch to soc, I will apply it to soc-
> > sh73a0.
> > 
> > I will, as before, merge all relevant branches into next.
> > 
> > I have also recently starting taging next branches, to provide a reference
> > point for developers. Unlike next, which changes every time I do a merge of
> > new changes, tags don't change (unless I make a mistake!). The current tag
> > is renesas-next-20130303. I plan to make renesas-next-20130304 shortly.
> > Please consider basing your work on the latest renesas-next tag. And please
> > consider quoting the tag name your work is based on when posting it.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
