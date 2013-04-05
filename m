From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 05 Apr 2013 00:07:17 +0000
Subject: Re: [PATCH 4/6] ARM: shmobile: r8a7740: Prepare for reference DT setup
Message-Id: <6502989.1xB3McauVL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1365083144-16085-4-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365083144-16085-4-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

On Thursday 04 April 2013 18:04:40 Bastian Hecht wrote:
> 2013/4/4 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> > Hi Bastian,
> > 
> > Thanks for the patch.
> > 
> > On Thursday 04 April 2013 15:45:42 Bastian Hecht wrote:
> >> We need two steps to prepare for the new Armadillo reference DT board
> >> code:
> >>  - Split the device list into r8a7740_early_devices used by the old
> >>  platform data setup (board-armadillo.c) and r8a7740_devices_dt used by
> >>  both setup variants.
> >> 
> >>  - Introduce new r8a7740_init_delay() to be more flexible about calling
> >>    shmobile_setup_delay().
> >> 
> >> This is similar to commit 3b00f9342623a5ebc
> >> "ARM: shmobile: sh73a0: Do not use early devices with DT reference"
> >> 
> >> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> >> ---
> >> 
> >>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 ++
> >>  arch/arm/mach-shmobile/setup-r8a7740.c        |   41   +++++++++--------
> >>  2 files changed, 23 insertions(+), 20 deletions(-)

[snip]

> >> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c
> >> b/arch/arm/mach-shmobile/setup-r8a7740.c index 228d7ab..ce0d2e6 100644
> >> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> >> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c

[snip]

> >> +void __init r8a7740_generic_init_early(void)
> > 
> > static void ?
> 
> I'm not sure, other people might want to use that in their board code
> when they don't have the need to set up the clocks with some special
> flags like we need it for Armadillo.

In that case they will need to patch the header file to declare 
r8a7740_generic_init_early, so they could as well remove the static at that 
point.

> >> +{
> >> +     r8a7740_clock_init(0);
> >> +     r8a7740_init_delay();
> >> 
> >>  }

-- 
Regards,

Laurent Pinchart

