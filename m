From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Nov 2014 00:42:36 +0000
Subject: Re: [GIT PULL] Third Round of Renesas ARM Based Soc Updates for v3.19
Message-Id: <20141120004236.GC5065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
 <201411192216.27740.arnd@arndb.de>
In-Reply-To: <201411192216.27740.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[ CC Geert ]

On Wed, Nov 19, 2014 at 10:16:27PM +0100, Arnd Bergmann wrote:
> On Thursday 13 November 2014, Simon Horman wrote:
> > ----------------------------------------------------------------
> > Third Round of Renesas ARM Based Soc Updates for v3.19
> > 
> > * Always build rcar setup for armv7
> >   - Fixes allmodconfig build fauilre caused by
> >     "ARM: shmobile: always build rcar setup for armv7"
> > * Add restart callback to sh73a0
> 
> Pulled into next/soc, thanks!
> 
> > ----------------------------------------------------------------
> > Arnd Bergmann (1):
> >       ARM: shmobile: always build rcar setup for armv7
> > 
> > Geert Uytterhoeven (1):
> >       ARM: shmobile: sh73a0: Add restart callback
> 
> I'm not too happy about the restart handler here: 
> 
> +#define RESCNT2 IOMEM(0xe6188020)
> +static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
> +{
> +       /* Do soft power on reset */
> +       writel((1 << 31), RESCNT2);
> +}
> 
> I see that you have the same thing in other SoCs, but I'd really want to
> see this done properly at some point and likely won't take future patches
> doing the same thing.
> 
> Please have a look at drivers/power/restart for how other platforms do
> this. You probably need to add a device node for whatever IP block
> holds the reset register and then have a driver. What exactly this
> driver should look like depends of course on what other registers are
> part of this block.

Hi Arnd,

thanks for your feedback and likewise for the kzm9g.
I will follow this up.
