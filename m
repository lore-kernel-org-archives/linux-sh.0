From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 May 2013 08:30:16 +0000
Subject: Re: [PULL] Renesas TPU PWM support
Message-Id: <20130510083015.GC27435@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <2913226.V7YaaHlrKR@avalon>
In-Reply-To: <2913226.V7YaaHlrKR@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 10, 2013 at 04:25:50PM +0900, Simon Horman wrote:
> On Thu, May 09, 2013 at 01:23:43PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > The following changes since commit 12e47d7dae97ea9474da500a555dc781d3b7ee55:
> > 
> >   Merge branch 'heads/soc-sh73a0' into next (2013-05-09 12:53:26 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/tpu
> > 
> > for you to fetch changes up to 56c8a8e245ddc6e1601e230d366139fba8432273:
> > 
> >   leds: Remove leds-renesas-tpu driver (2013-05-09 13:00:18 +0200)
> > 
> > The patches have already been posted to the list, I've just rebased them on 
> > top of renesas-next-20130509. Feel free to pick them up manually or rebase 
> > them if needed, or even ask me to rebase them on top of a different 
> > branch/tag.
> 
> Hi Laurent,
> 
> I had hoped to get to this today but I didn't quite make it.
> I should be able to process it on Monday.

It turns out that I had a bit more time than expected this afternoon.

I am a bit unsure of how to handle applying this patchset to
different branches without creating a dependency nightmare.
So for now I have queued-up all the patches for v3.11 in the pinmux
branch. I will push this and a renesas-next-20130510 tag once my
build and boot tests finish (successfully!).
