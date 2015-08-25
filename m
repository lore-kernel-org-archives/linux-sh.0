From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Aug 2015 05:50:03 +0000
Subject: Re: [PATCH v2 03/07] ARM: shmobile: Add APMU nodes to r8a7790 DTSI
Message-Id: <1526541.cKGtqzOZAK@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple> <1534893.ppOlo5pCGu@avalon> <CANqRtoQev9=mA_rHBKDOMisoi2o8eekiPPfbG+wUjR0yFK-uCQ@mail.gmail.com>
In-Reply-To: <CANqRtoQev9=mA_rHBKDOMisoi2o8eekiPPfbG+wUjR0yFK-uCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?utf-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym@renesas.com>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Magnus,

On Tuesday 25 August 2015 13:13:46 Magnus Damm wrote:
> On Tue, Aug 25, 2015 at 3:29 AM, Laurent Pinchart wrote:
> > On Sunday 23 August 2015 16:25:00 Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> 
> >> Add an APMU DT node for the r8a7790 SoC and use the enable-method to
> >> point out that the APMU should be used for SMP support.
> >> 
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >> ---
> >> 
> >>  Changes from V1:
> >>  - New patch
> >>  
> >>  arch/arm/boot/dts/r8a7790.dtsi |   13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >> 
> >> --- 0001/arch/arm/boot/dts/r8a7790.dtsi
> >> +++ work/arch/arm/boot/dts/r8a7790.dtsi       2015-08-23
> >> 15:51:24.132366518 +0900 @@ -43,6 +43,7 @@
> >>       cpus {
> >>               #address-cells = <1>;
> >>               #size-cells = <0>;
> >> +             enable-method = "renesas,apmu";
> >> 
> >>               cpu0: cpu@0 {
> >>                       device_type = "cpu";
> >> @@ -112,6 +113,18 @@
> >>               };
> >>       };
> >> 
> >> +     apmu@e6151000 {
> >> +             compatible = "renesas,apmu-r8a7790", "renesas,apmu";
> >> +             reg = <0 0xe6151000 0 0x188>;
> >> +             cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
> >> +     };
> >> +
> >> +     apmu@e6152000 {
> >> +             compatible = "renesas,apmu-r8a7790", "renesas,apmu";
> >> +             reg = <0 0xe6152000 0 0x188>;
> >> +             cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
> >> +     };
> > 
> > I wonder whether those two nodes shouldn't be moved inside the CPG node as
> > it seems that the APMU is part of the CPG IP core. We can delay that
> > though, as the Gen3 DTS will need to be refactored anyway.
> 
> Hm, I don't mind reworking things, but with power domain focus I sort
> of expected the APMU to be closer to SYSC than the CPG actually...

So did I, but the APMU is in the CPG address range, and is documented in the 
datasheet in the same section as the CPG (7. for CPG, 7A. for MSTP and 7B. for 
APMU). Don't ask me why :-)

-- 
Regards,

Laurent Pinchart

