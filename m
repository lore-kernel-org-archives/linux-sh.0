From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Aug 2015 05:28:52 +0000
Subject: Re: [PATCH v2 00/07] ARM: shmobile: APMU DT support via SMP Enable method V2
Message-Id: <20150826052851.GA9515@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple>
 <20150825004923.GC17673@verge.net.au>
 <CANqRtoQzpNSr8dWRvGmS_VWBEsi-=dB6PUGVzWQHAXK6xb2f2A@mail.gmail.com>
In-Reply-To: <CANqRtoQzpNSr8dWRvGmS_VWBEsi-=dB6PUGVzWQHAXK6xb2f2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, =?utf-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

[resending as vegr rejected the previous attempt]

On 25 August 2015 at 13:09, Magnus Damm <magnus.damm@gmail.com> wrote:

> Hi Simon,
>
> On Tue, Aug 25, 2015 at 9:49 AM, Simon Horman <horms@verge.net.au> wrote:
> > Hi Magnus,
> >
> > On Sun, Aug 23, 2015 at 04:24:27PM +0900, Magnus Damm wrote:
> >> ARM: shmobile: APMU DT support via SMP Enable method V2
> >>
> >> [PATCH v2 01/07] devicetree: bindings: Renesas APMU and SMP Enable
> method
> >> [PATCH v2 02/07] ARM: shmobile: Add APMU DT support via Enable method
> >> [PATCH v2 03/07] ARM: shmobile: Add APMU nodes to r8a7790 DTSI
> >> [PATCH v2 04/07] ARM: shmobile: Add APMU nodes to r8a7791 DTSI
> >> [PATCH v2 05/07] ARM: shmobile: Add function to prioritize DT SMP
> >> [PATCH v2 06/07] ARM: shmobile: Prioritize r8a7790 DT APMU support
> >> [PATCH v2 07/07] ARM: shmobile: Prioritize r8a7791 DT APMU support
> >>
> >> These patches add DT support for the APMU hardware commonly found in
> >> Renesas R-Car Gen2 SoCs. Without these patches the APMU gets configured
> >> through data expressed in C, and with this series applied it is possible
> >> to describe the APMU configuration in DT and let the enable method point
> >> out that the APMU should be used.
> >>
> >> Patch 1 and 2 are Documenting and adding DT support to the APMU driver
> >> together with enabling use of the enable-method way to describe that
> >> the APMU hardware is needed for SMP operation.
> >>
> >> Patch 3 and 4 are related to r8a7790/r8a7791 support that get a DTSI
> update
> >> to describe the APMU hardware. To avoid breaking support for older DTBs
> out
> >> in the wild these patches keep the older existing C code APMU
> configuration
> >> as-is. Patch 5-7 make sure that during run-time, if the APMU is
> installed
> >> via the DT enable-method then it will not be overriden by older non-DT
> >> configuration.
> >>
> >> I suggest making APMU DT configuration mandatory for SMP operation on
> >> newer SoCs and that we keep the old APMU support code in place for a
> >> good number of kernel releases or until we can identify a couple of
> major
> >> reasons good enough to force a DTB update on the end users.
> >>
> >> In the future r8a7793 and r8a7794 support may be added by using code
> >> similar to patch 3 and 4 but without any C-based SMP code and fallback.
> >
> > Sounds reasonable.
> >
> > Looking over the review of this series I see only one minor comment
> > regarding spelling in documentation. I have it in mind to queue up
> > this series with that problem fixed unless objections are raised
> > in the near future. Please feel free to convince me otherwise or
> > repost the series with the spelling error fixed.
>
> Thanks for your feedback! My plan is to update this series once more
> early next month, so no need to pick anything up right now.
>

Thanks, I will immediately do nothing.


> I feel that we should discuss with the ARM SoC guys about the reason
> why SMP Enable DT binding is needed. From my side it seems enough to
> determine the SMP configuration from the SoC part number (and maybe
> APMU DT bits) that we already have encoded in DT.
>
> Perhaps discussing that at ELCE would be good?
>
> Best,
>
> / magnus
>
>
