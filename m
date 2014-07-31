From: Simon Horman <horms@verge.net.au>
Date: Thu, 31 Jul 2014 02:29:32 +0000
Subject: Re: [PATCH 00/09] ARM: shmobile: Consistent use of shmobile_init_late()
Message-Id: <20140731022928.GB2558@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140730233206.5969.26669.sendpatchset@w520>
In-Reply-To: <20140730233206.5969.26669.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2014 at 10:05:03AM +0900, Magnus Damm wrote:
> On Thu, Jul 31, 2014 at 9:12 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jul 31, 2014 at 08:32:06AM +0900, Magnus Damm wrote:
> >> ARM: shmobile: Consistent use of shmobile_init_late()
> >>
> >> [PATCH 01/09] ARM: shmobile: Add shmobile_init_late() to sh73a0
> >> [PATCH 02/09] ARM: shmobile: Add shmobile_init_late() to KZM9G
> >> [PATCH 03/09] ARM: shmobile: Fix shmobile_init_late() on r8a7779
> >> [PATCH 04/09] ARM: shmobile: Add shmobile_init_late() to Marzen
> >> [PATCH 05/09] ARM: shmobile: Fix shmobile_init_late() on r8a7778
> >> [PATCH 06/09] ARM: shmobile: Add shmobile_init_late() to Bock-W
> >> [PATCH 07/09] ARM: shmobile: Add shmobile_init_late() to r8a73a4
> >> [PATCH 08/09] ARM: shmobile: Add shmobile_init_late() to APE6EVM
> >> [PATCH 09/09] ARM: shmobile: Add shmobile_init_late() to r7s72100
> >>
> >> Make sure all mach-shmobile SoCs and DT Reference board support code
> >> call shmobile_init_late() so Suspend-to-RAM and CPUIdle get setup
> >> in a consistent way. The SoC DT case for r8a7778 and r8a7779 are
> >> also adjusted to not add any platform devices. DT shall be used instead.
> >
> > Hi Magnus,
> >
> > these patches seem fine for me but I wonder if you could follow the
> > convention that has emerged as being dominant for subjects
> > for shmobile patches.
> >
> > * Using lowercase for SOC names
> > * Omitting hyphens from boards names (i.e. bockw)
> > * Putting the board or soc after "shmobile: " and followed by a ':'.
> >
> > I have taken the liberty of updating the patch names to the
> > following and queued up the result:
> >
> > ARM: shmobile: sh73a0: Add shmobile_init_late()
> > ARM: shmobile: kzm9g: Add shmobile_init_late()
> > ARM: shmobile: r8a7779: Fix shmobile_init_late()
> > ARM: shmobile: marzen: Add shmobile_init_late()
> > ARM: shmobile: r8a7778: Fix shmobile_init_late()
> > ARM: shmobile: bockw: Add shmobile_init_late()
> > ARM: shmobile: r8a73a4: Add shmobile_init_late()
> > ARM: shmobile: ape6evm: Add shmobile_init_late()
> > ARM: shmobile: r7s72100: Add shmobile_init_late()
> >
> > The reason for requesting this is that from time to time
> > I in turn receive requests to make subjects consistent.
> 
> Hi Simon,
> 
> Thanks for fixing up inconsistencies and picking up patches. I agree
> with the hyphen removal - why on earth would anyone want a hyphen in
> their board name anyway? Lower case SoC name makes sense - with the
> exception on EMEV2, but I'm fine adjusting that to lower case too. =)
>
> The upper case board name is something that i've used over many years,
> but I will do my best to try to adjust my default mode of operation
> and stick to lower case from now on.

Thanks, I know that everyone isn't entirely sold on the convention.
But it seems easiest to follow it for now.

I agree about the hyphen :)
