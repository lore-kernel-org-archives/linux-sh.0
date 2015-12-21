From: Simon Horman <horms@verge.net.au>
Date: Mon, 21 Dec 2015 04:34:48 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7794: use fallback usbhs compatibility string
Message-Id: <20151221043447.GF14422@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
 <1450404705-5449-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVAPYj5X4uF4vgfufnVToywBEAj9mwAgz0VQauUCB6m=Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVAPYj5X4uF4vgfufnVToywBEAj9mwAgz0VQauUCB6m=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 18, 2015 at 11:16:11AM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 18, 2015 at 3:11 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -724,7 +724,7 @@
> >         };
> >
> >         hsusb: usb@e6590000 {
> > -               compatible = "renesas,usbhs-r8a7794";
> > +               compatible = "renesas,usbhs-r8a7794", "renesas,usbhs";
> 
> "renesas,rcar-gen2-usbhs", not "renesas,usbhs".
> 
> (no complaints from checkpatch.pl?)

Silly me, I will fix that.
