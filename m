From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 21 Mar 2012 22:19:14 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: Reserve DMA memory for the frame buffer
Message-Id: <201203212319.14583.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4wxi7sn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4wxi7sn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, March 21, 2012, Rafael J. Wysocki wrote:
> On Thursday, March 15, 2012, Paul Mundt wrote:
> > On Tue, Mar 13, 2012 at 11:59:33AM +0900, Paul Mundt wrote:
> > > On Mon, Mar 12, 2012 at 06:55:23PM -0700, Kuninori Morimoto wrote:
> > > > ap4evb board needs the same fix as
> > > > 1740d3448012475f6b63172631c60cbcd1994a81
> > > > (ARM: mach-shmobile: mackerel: Reserve DMA memory for the frame buffer)
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Too late now, we'll have to apply it in 3.4 and flag it for -stable. -rc7
> > > is not the time to be testing and submitting fixes that should have been
> > > done during -rc3 time or so.
> > 
> > Ok, I've applied it to my fixes branch for now. If there's another rc
> > I'll send it off to Linus, otherwise Rafael can pull in my outstanding
> > fixes later on.
> 
> Can you please tell me which branch they are on?

Found it, sorry for the noise.

Rafael
