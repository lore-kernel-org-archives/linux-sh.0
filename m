From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Oct 2010 10:39:17 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Add memchunk support V2
Message-Id: <20101015103917.GE7489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101014092152.2046.29572.sendpatchset@t400s>
In-Reply-To: <20101014092152.2046.29572.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 14, 2010 at 06:21:52PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add SH-Mobile ARM support for "memchunk" V2. The code is based
> on the SH implementation but has been slightly modified to use 
> memblock for physical memory reservation.
> 
There are two issues here..

- first:

Is there any reason not to use the same approach on SH? I rather dislike
having wholly generic code split between the architectures for no reason,
as seems to be the trend lately.

All of this started out abusing the platform_ namespace because it
related to platform devices, as it still does. You were told previously
to run this by gregkh and make a drivers/base/platform.c push for it
the last time you posted these patches, and so far I haven't seen any
progress in that department.

Now you've moved on to memblock allocation/reservation, which while not
as generic as the DMA allocator, is still common between all the
platforms that care about this. The only stuff that really belongs in the
architecture subdirectories are the reservation callbacks, which in this
case we can quite easily wrap in to a generic callback.

Now that memblock is common enough, the alternative you have is simply to
do the reservations from the ->reserve() callback and then have the
driver code grovel for a mapping with memblock_find(). You can of course
use ATAGs to aid in this if you wish, as OMAP does for its framebuffer
memory.

- second, and more fundamental:

My main concern however is that this basically won't work for the common
platform device case on ARM given that all of the memblock allocations
have valid backing PFNs. The UIO case "works" by virtue of blindsiding
the remap path and calling in to remap_pfn_range() directly, which is
unaware of any architectural limitations. Any non-UIO driver using this
scheme today will just error out on the first ioremap() once the
pfn_valid() check returns.

In order to support this properly you will need to punch out memblock
region holes, not unlike the ARCH_HAS_HOLES_MEMORYMODEL behaviour, albeit
with a bit more flexibility. I vaguely recall having mentioned this
before, too.
