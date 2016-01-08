From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jan 2016 23:15:36 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <26406091.ZqfajlYvbG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx> <7119737.DzNTr3WlaV@avalon> <20160108194009.GM238@brightrain.aerifal.cx>
In-Reply-To: <20160108194009.GM238@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Rob Landley <rob@landley.net>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>

Hi Rich,

On Friday 08 January 2016 14:40:09 Rich Felker wrote:
> On Fri, Jan 08, 2016 at 08:28:51PM +0200, Laurent Pinchart wrote:
> >> The current list is not a Renesas list, it is a Linux list for the
> >> SuperH architecture port. Says so on the tin, and that was its history
> >> until pretty recently. Renesas moving away from the SuperH architecture
> >> doesn't change that this is the Linux arch/sh list.
> >> 
> >> We aren't proposing to rename the arch/sh directory to "jcore", so
> >> "linux-sh@vger.kernel.org" remains the logical name for this list. The
> >> new stuff is intentionally backwards compatible with the old stuff,
> > 
> > How about IP cores around the CPU, do you plan to develop cores compatible
> > with the Renesas implementations, or go for something else ? If we end up
> > sharing the same peripherals between multiple architectures we will need
> > to decide on how to coordinate the work.
> 
> To my knowledge, aside from the cpu which is of course ISA-compatible,
> none of the current J-Core SOC components ("IP") are
> interface-compatible with Renesas ones.

OK, that answers my question. It won't be difficult to setup collaboration on 
drivers if we don't need to collaborate :-)

> I'm aiming to put as much as possible in drivers/ rather than arch/sh/
> because it should all be shareable with other open-hardware cpus.

Absolutely, that's the right way to do it I believe.

> We're already using uartlite from drivers/ and I have some patches for it I
> still need to send upstream, including SMP fixes and earlycon support.
> 
> > > and we are happy to maintain compatibility with the old stuff, and have
> > > current plans to move it to device tree. (We just need a lot more legacy
> > > test hardware...)
> > 
> > I personally don't think that's worth it given that most of the legacy
> > hardware is buried under a thick layer of dust (when not used as coasters
> > or door stoppers).
> 
> We probably need to gauge the level of interest in preserving support
> for legacy hardware. I don't want to gratuitously drop anything, and I
> think the device tree conversion will help us avoid that to some
> extent by moving the bulk of hardware/board support from code to data,
> but I will need to find a way to get my hands on some of the old
> hardware if we want to verify that I'm not breaking it.

I don't think there's much interest on Renesas' side. If nobody had stepped up 
to maintain arch/sh a patch to drop it completely would have been sent this 
year I believe. Anything that can be done without too much effort is fine 
(assuming you can get your hands on test hardware), just don't feel pressured.

And if it all means that we can remove platform data support at some point 
from drivers that kept it for arch/sh only, I'll be happy with that.

> Another consideration is what qemu emulates, which right now is the
> legacy hardware. After J2 support, my first sh kernel priority is
> getting to the point where it can boot in qemu-system-sh4 using device
> tree, and where qemu can be configured based on a device tree, so that
> we can actually provide a reasonable amount of ram to run a modern
> system. I know Rob is interested in this to be able to test full
> system builds, native compiling, etc.

-- 
Regards,

Laurent Pinchart

