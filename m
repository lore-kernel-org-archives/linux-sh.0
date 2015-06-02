From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Jun 2015 00:27:48 +0000
Subject: Re: [PATCH v4 2/4] ARM: shmobile: add r8a7793 minimal SoC device tree
Message-Id: <20150602002747.GA4781@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1432826157-6414-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1432826157-6414-3-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdXr3BxULQohYo1U0RuW8SRTtb5Ge_ypAbByW8vuRWs=PA@mail.gmail.com>
 <CAO3366wm=LvYntDYBwh9AY-jpfmBF57cJhfY2A=yAk13kHg3oQ@mail.gmail.com>
In-Reply-To: <CAO3366wm=LvYntDYBwh9AY-jpfmBF57cJhfY2A=yAk13kHg3oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jun 01, 2015 at 11:45:45AM +0200, Ulrich Hecht wrote:
> On Mon, Jun 1, 2015 at 11:37 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Hi Ulrich,
> >
> > On Thu, May 28, 2015 at 5:15 PM, Ulrich Hecht
> > <ulrich.hecht+renesas@gmail.com> wrote:
> >> Minimal r8a7793 device tree including one CPU core, interrupt controllers,
> >> timers, two serial ports, and the Ethernet controller, plus the required
> >> clock descriptions.
> >
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> >> @@ -0,0 +1,368 @@
> >
> >> +       cpus {
> >> +               #address-cells = <1>;
> >> +               #size-cells = <0>;
> >> +
> >> +               cpu0: cpu@0 {
> >> +                       device_type = "cpu";
> >> +                       compatible = "arm,cortex-a15";
> >> +                       enable-method = "renesas,r8a7793";
> >
> > I don't think we need the enable-method in a minimal tree, do we?
> 
> Nope.

Could you respin without the enable-method?

I see there is also a minor Makefile change pending for the last patch of
the series. With that and the above in place I think we should be very
close.

> >> +       clocks {
> [...]
> >> +       };
> >
> > I don't see the rationele behind keeping some mstp clocks, and others not,
> > for a miminal dtsi.
> 
> Some clocks are required by the minimal set of devices, and I did not
> want to take apart individual MSTPs because IMO it's error-prone and
> does not provide any real benefit.

My feeling is that while it would be ideal to trim things down it
this is reasonable not to do so to avoid breaking what is left.

I lean towards taking the MSTP clocks as is.
