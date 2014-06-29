From: Simon Horman <horms@verge.net.au>
Date: Sun, 29 Jun 2014 00:06:24 +0000
Subject: Re: [PATCH v2 01/07] ARM: shmobile: Allow use of boot code for non-SMP case
Message-Id: <20140629000621.GD9487@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606072010.14868.5474.sendpatchset@w520>
In-Reply-To: <20140606072010.14868.5474.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 25, 2014 at 06:32:47PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jun 25, 2014 at 5:04 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Jun 06, 2014 at 04:20:10PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Allow build of platsmp.c and headsmp.S even though
> >> SMP is disabled in the kernel configuration. With
> >> this in place it is possible to share the reset
> >> vector setup code with power management code that
> >> needs to be built even though SMP is disabled.
> >>
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >
> > Hi Magnus,
> >
> > could you let me know what the status of this series is.
> > Should I queue it up?
> 
> I think Komayashi-san did some testing earlier (thanks), and in my
> mind the series is a step in the right direction. So please queue it
> up!

Thanks, I have done so.
