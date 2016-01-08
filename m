From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 19:40:09 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <20160108194009.GM238@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108065642.GA1215@verge.net.au>
 <568FF369.9080006@landley.net>
 <7119737.DzNTr3WlaV@avalon>
In-Reply-To: <7119737.DzNTr3WlaV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rob Landley <rob@landley.net>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>

On Fri, Jan 08, 2016 at 08:28:51PM +0200, Laurent Pinchart wrote:
> > The current list is not a Renesas list, it is a Linux list for the
> > SuperH architecture port. Says so on the tin, and that was its history
> > until pretty recently. Renesas moving away from the SuperH architecture
> > doesn't change that this is the Linux arch/sh list.
> > 
> > We aren't proposing to rename the arch/sh directory to "jcore", so
> > "linux-sh@vger.kernel.org" remains the logical name for this list. The
> > new stuff is intentionally backwards compatible with the old stuff,
> 
> How about IP cores around the CPU, do you plan to develop cores compatible 
> with the Renesas implementations, or go for something else ? If we end up 
> sharing the same peripherals between multiple architectures we will need to 
> decide on how to coordinate the work.

To my knowledge, aside from the cpu which is of course ISA-compatible,
none of the current J-Core SOC components ("IP") are
interface-compatible with Renesas ones. I'm aiming to put as much as
possible in drivers/ rather than arch/sh/ because it should all be
shareable with other open-hardware cpus. We're already using uartlite
from drivers/ and I have some patches for it I still need to send
upstream, including SMP fixes and earlycon support.

> > and we are happy to maintain compatibility with the old stuff, and have
> > current plans to move it to device tree. (We just need a lot more legacy
> > test hardware...)
> 
> I personally don't think that's worth it given that most of the legacy 
> hardware is buried under a thick layer of dust (when not used as coasters or 
> door stoppers).

We probably need to gauge the level of interest in preserving support
for legacy hardware. I don't want to gratuitously drop anything, and I
think the device tree conversion will help us avoid that to some
extent by moving the bulk of hardware/board support from code to data,
but I will need to find a way to get my hands on some of the old
hardware if we want to verify that I'm not breaking it.

Another consideration is what qemu emulates, which right now is the
legacy hardware. After J2 support, my first sh kernel priority is
getting to the point where it can boot in qemu-system-sh4 using device
tree, and where qemu can be configured based on a device tree, so that
we can actually provide a reasonable amount of ram to run a modern
system. I know Rob is interested in this to be able to test full
system builds, native compiling, etc.

Rich
