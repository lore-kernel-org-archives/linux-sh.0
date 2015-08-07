From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 07 Aug 2015 10:19:59 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen: Board specific serial port order
Message-Id: <2257759.5dtALz1Flu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150807024533.25666.34925.sendpatchset@little-apple>
In-Reply-To: <20150807024533.25666.34925.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 07 August 2015 09:13:08 Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Fri, Aug 7, 2015 at 4:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> > 
> > Convert Marzen to use board-specific serial0 and serial1 instead
> > of the older shared SoC-specific SCIF index.
> 
> Thank you for your patch!
> 
> Please note that this is a user-visible change.
> Hardcoded "ttySC2" in e.g. kernel boot command line and /etc/inittab must be
> changed to ttySC0.
> 
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Nevertheless:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

And

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

given how long I've been pushing for this :-)

> > --- 0001/arch/arm/boot/dts/r8a7779-marzen.dts
> > +++ work/arch/arm/boot/dts/r8a7779-marzen.dts   2015-08-07
> > 11:04:37.432366518 +0900 @@ -19,12 +19,12 @@
> >         compatible = "renesas,marzen", "renesas,r8a7779";
> >         
> >         aliases {
> > -               serial2 = &scif2;
> > -               serial4 = &scif4;
> > +               serial0 = &scif2;
> > +               serial1 = &scif4;
> >         };
> >         
> >         chosen {
> > -               bootargs = "console=ttySC2,115200 ignore_loglevel
> > root=/dev/nfs ip=on";
>
> The "console=..." part can indeed be removed, now legacy marzen is gone.
>
> > +               bootargs = "ignore_loglevel root=/dev/nfs ip=on";
> >                 stdout-path = &scif2;
> >         };

-- 
Regards,

Laurent Pinchart

