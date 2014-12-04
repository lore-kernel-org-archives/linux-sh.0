From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 11:45:36 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 CCF DTS update
Message-Id: <20141204114535.GB19465@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203115145.5889.72521.sendpatchset@w520>
In-Reply-To: <20141203115145.5889.72521.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 04, 2014 at 05:57:19PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Dec 4, 2014 at 4:15 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Dec 04, 2014 at 01:37:10PM +0900, Magnus Damm wrote:
> >> Hi Geert,
> >>
> >> On Wed, Dec 3, 2014 at 9:56 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> > Hi Magnus,
> >> >
> >> > On Wed, Dec 3, 2014 at 1:52 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> >> On Wed, Dec 3, 2014 at 9:25 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> >>> On Wed, Dec 3, 2014 at 12:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> >>>> Update the r8a7779 CCF DTS with the following fixes:
> >> >>>>  - Use MSTP0 for SCIF clock control
> >> >>>>  - Use R8A7779_CLK_P as parent clock for SCIF (same as legacy code)
> >> >>>>  - Use "clock-indicies" instead of "renesas,clock-indices"
> >> >>>
> >> >>> We already have
> >> >>> "[PATCH v2 3/6] ARM: shmobile: r8a7779 dtsi: Change to using clock-indices"
> >> >>> (http://www.spinics.net/lists/linux-sh/msg37285.html) for the latter.
> >> >>
> >> >> Yes, I noticed that too late I'm afraid. =)
> >> >>
> >> >> Are you aware of any outstanding issue for that series?
> >> >
> >> > Not that I'm aware of. As Mike merged the bindings update, I had pinged
> >> > Simon about the rest of the series, just before you sent your patch.
> >>
> >> Thanks, sounds like I should make a V2 of this patch once Simon has
> >> merged patch 3/6 above.
> >
> > In general I prefer one fix per patch.
> >
> > So unless there is a dependency between the remaining two fixes
> > could you please make them separate patches when you drop the
> > clock-indicies changes?
> 
> I think both are needed to make it work, but I don't mind breaking
> them out into two separate commits. I agree that it is cleaner.

Thanks, I think that would be best.
