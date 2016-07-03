From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 11:34:27 +0000
Subject: Re: [PATCH v4 14/22] sh: SH7751 core dtsi
Message-Id: <87wpl3rm4c.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
	<1467207667-15768-15-git-send-email-ysato@users.sourceforge.jp>
	<CAMuHMdUOZnQ9GLwx9=scrVBFXUh2LOKyCYRuEVUgKWWhpBotbg@mail.gmail.com>
In-Reply-To: <CAMuHMdUOZnQ9GLwx9=scrVBFXUh2LOKyCYRuEVUgKWWhpBotbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 01 Jul 2016 17:57:00 +0900,
Geert Uytterhoeven wrote:
> 
> Hi Sato-san,
> 
> On Wed, Jun 29, 2016 at 3:40 PM, Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > SH7751 core and internal peripheral define.
> 
> Thanks for your patch!
> 
> > Changes v4
> > - remove unneeded #address-cells and #size-cells
> > - add missing dt-binding link
> 
> Please move changelog information below the three dashes...
> 
> >
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> 
> ... i.e. here.

OK.

> > --- /dev/null
> > +++ b/arch/sh/boot/dts/include/dt-bindings
> > @@ -0,0 +1 @@
> > +../../../../../include/dt-bindings
> > \ No newline at end of file
> 
> Missing newline.

This file is symbolic link.
I think not need newline.

> > --- /dev/null
> > +++ b/arch/sh/boot/dts/sh7751.dtsi
> 
> > +       oclk: oscillator {
> > +                #clock-cells = <0>;
> > +                compatible = "fixed-clock";
> > +                clock-frequency = <0>;
> > +        };
> > +       cpg: cpg@ffc00000 {
> 
> clock-controller@ffc00000

OK.

> > \ No newline at end of file
> 
> Missing newline.

OK.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
