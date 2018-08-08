From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Aug 2018 11:02:50 +0000
Subject: Re: [PATCH/RFC 0/4] sh-sci : Do not derive regshift from regsize
Message-Id: <CAMuHMdX1bbOhtpVrjNC5hAAR8y_+f9eM1STigxMhWUZEdkJzZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, uli@fpond.eu, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

On Mon, Aug 6, 2018 at 4:08 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This RFC patch series was sparked by noticing that commit 2d4dd0da45401c7a
> ("serial: sh-sci: Allow for compressed SCIF address") broke earlycon
> support on most Renesas ARM SoCs using SCIF ports, and by the fragility of
> deriving regshift from the register block size (which may be rounded up):
>   1. The first patch is an old patch from Sato-san, which I never really
>      understood.  But it turned out to be a dependency for patch 2.
>   2. Patch 2 makes sure regshift is initialized when using earlycon,
>      unbreaking the serial console on e.g. R-Car Gen2 and Gen3.
>   3. Patch 3 reverts the patch that started deriving regshift from the
>      register block size, and that removed the plat_sci_port.regshift
>      field.  Which is a field I needed again in patch 4.
>   4. Patch 4 removes the remaining regshift derivations on DT platforms.
>  (5. I didn't bother writing patch 5, which involves adding .regshift
>      initializations to all SH board files that need it.)
>
> However, I'm not happy with the end result, so please DO NOT apply this!
> As I spent almost a full day on this, and would still like to know the
> story about "sh-sci: Use a separate sci_port for earlycon", I decided to
> post it anyway.
>
> As earlycon will be broken in v4.19-rc1 on RZ/A1, RZ/G, and R-Car, assuming
> no other actions are taken, an alternative solution would be to:
>   1. Revert commit 7acece71a517cad8 ("serial: sh-sci: Remove
>      SCIx_RZ_SCIFA_REGTYPE"),
>   2. Revert commit 2d4dd0da45401c7a ("serial: sh-sci: Allow for compressed
>      SCIF address") alternative,
>   3. Add an OF_EARLYCON_DECLARE() for RZ/A2, to fix earlycon on RZ/A2.
>
> What do you think?
> Thanks for your comments!

I gave this a bit more thought, and these are my conclusions:
  1. RZ/A2 SCIF is not really compatible with SCIF on RZ/A1, RZ/G, and
     R-Car, due to the absence of support for the DT "reg-shift" property.
     Given RZ/A1 and R-Car would need "reg-shift = <1>", we cannot
     retroactively add support for that for ports declared compatible with
     "renesas,scif" (assuming regshift = 1 in case the "reg-shift"
     property is not present may work for the main serial driver, but not
     for earlycon, where of_setup_earlycon() is in charge of all register
     block parsing).
     Sorry for suggesting this in the first place. Based on the regshift
     handling for SCI, I assumed it was fine, but apparently that
     particular code isn't without problems on SCI ports neither.
  2. SCI ports are the only ports where a DT "reg-shift" property makes
     sense, as it is the only port type with fixed (8-bit) register sizes,
     with registers spaced 1, 2 or 4 bytes apart (regshift = 0, 1, or 2).
     All other types use a mix of 8-bit and 16-bit registers, 2 or 4 bytes
     apart.
       - On H8/300 (DT only), regshift is always zero.
         AFAIK this is handled correctly for earlycon, but not for the main
         serial driver (presumably broken since commit
         dfc80387aefb78161f83732804c6d01c89c24595, cfr. Sato-san's patch
         "serial: sh-sci: byte allocated register support"
         (https://www.spinics.net/lists/linux-sh/msg53175.html)).
       - On SuperH (non-DT), regshift is 1 or 2.
         If/when DT support is ever added, the "reg-shift" DT property can
         be used to indicate that.

Suggestions for actions:
  1. Revert commit 7acece71a517cad8 ("serial: sh-sci: Remove
     SCIx_RZ_SCIFA_REGTYPE"), as this is a dependency for step 2,
  2. Revert commit 2d4dd0da45401c7a ("serial: sh-sci: Allow for compressed
     SCIF address"), to unbreak earlycon on RZ/A1, RZ/G, and R-Car SCIF
     ports,
  3. Restrict the regshift setup (1 or 2) for PORT_SCI to the
     !dev->dev.of_node case, to fix SCI ports instantiated from DT on
     H8/300.
  4. Drop "renesas,scif" from the compatible value in the (not yet
     submitted) r7s9210.dtsi (this may have to be clarified in the DT
     bindings, although they already say "renesas,scif" is only meant for
     ports compatible with the generic version, whatever that means ;-),
  5. Add an OF_EARLYCON_DECLARE() for RZ/A2, setting port_cfg.regtype to
     SCIx_RZ_SCIFA_REGTYPE, to (presumably) make earlycon work on RZ/A2,

1-2 are regression fixes that can be done immediately,
3 is a bug fix to be submitted,
5 is an enhancement to be submitted.

Any other opinions or comments?

As both Greg and I will be on holidays until after the v4.18 release, you
have a bit more time to polish all of this for the serial pull request
for v4.19...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
