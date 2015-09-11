From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2015 06:55:38 +0000
Subject: Re: [PATCH 06/14][RFC] arm64: renesas: r8a7795: add SSI DMA support
Message-Id: <CAMuHMdWemm2oNDchrNz-ojt1xac-TwGgm8xr+7UBDfMSiJiV+Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Sep 11, 2015 at 2:25 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> >> >                                 ssi0: ssi@0 {
>> >> >                                         interrupts =3D <0 370 IRQ_T=
YPE_LEVEL_HIGH>;
>> >> > +                                       dmas =3D <&audma0 0x01>, <&=
audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
>> >> > +                                       dma-names =3D "rx", "tx", "=
rxu", "txu";
>> >> >                                 };
> (snip)
>> E.g. the Gen2/Gen3 datasheets says SSI0_0 TX MID/RID is 0x15, not 0x16,
>> so the r8a7791 and r8a7795 dtsis are both wrong?
>
> Sorry, it is very confusable.
> Sound driver is assuming rx, tx for SSI point.
>
>      tx    rx
> [DMA]------->[SSI]
>      <------
>      rx    tx

Documentation/devicetree/bindings/sound/renesas,rsnd.txt says:

    - dma                           : Should contain Audio DMAC entry
    - dma-names                     : SSI  case "rx"  (=3Dplayback),
"tx"  (=CApture)
                                      SSIU case "rxu" (=3Dplayback),
"txu" (=CApture)

E.g. for "rx" =3D "playback", the SSI receives data from the DMA engine,
and sends it over the I2S link?

So the documentation uses the viewpoint of the DMA engine?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
