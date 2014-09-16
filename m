From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Sep 2014 00:45:09 +0000
Subject: Re: [PATCH 3/6] ARM: shmobile: kzm9d: sort dts file by address
Message-Id: <20140916004508.GF26557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410511876-9235-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1410511876-9235-4-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdXY70_aWsVjYSZUPCcbTgJ6CnwHEziwr1PBDyS6RLjj2w@mail.gmail.com>
In-Reply-To: <CAMuHMdXY70_aWsVjYSZUPCcbTgJ6CnwHEziwr1PBDyS6RLjj2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Olof Johansson <olof@lixom.net>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Fri, Sep 12, 2014 at 10:58:37AM +0200, Geert Uytterhoeven wrote:
> Hi Ulrich,
> 
> I know this is not your fault, but...
> 
> On Fri, Sep 12, 2014 at 10:51 AM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > +       reg_1p8v: regulator@0 {
> 
> As there is no "reg" property, the "@0" must not be present.
> However, in the absence of a unit-address, the node name must be unique.

Bother.

Ulrich, could you correct this and other problems raised
by Geert in relation to other patches; rebase this series;
and repost?

Ideally I would like to include these patches early
on in the cycle for v3.19.

> > +               compatible = "regulator-fixed";
> > +               regulator-name = "fixed-1.8V";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               regulator-always-on;
> > +               regulator-boot-on;
> > +       };
> > +
> > +       reg_3p3v: regulator@1 {
> 
> Likewise.
> 
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "fixed-3.3V";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               regulator-always-on;
> > +               regulator-boot-on;
> > +       };
> 
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
