From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Sep 2015 08:08:48 +0000
Subject: Re: [PATCH 06/14][RFC] arm64: renesas: r8a7795: add SSI DMA support
Message-Id: <CAMuHMdW0P6xH4qToyxQB5BZJzcxmZ3_bFRL3esoOtQ02Tj5fDw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io7in3xo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Sep 11, 2015 at 10:03 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> Documentation/devicetree/bindings/sound/renesas,rsnd.txt says:
>>
>>     - dma                           : Should contain Audio DMAC entry
>>     - dma-names                     : SSI  case "rx"  (=3Dplayback),
>> "tx"  (=CApture)
>>                                       SSIU case "rxu" (=3Dplayback),
>> "txu" (=CApture)
>>
>> E.g. for "rx" =3D "playback", the SSI receives data from the DMA engine,
>> and sends it over the I2S link?
>>
>> So the documentation uses the viewpoint of the DMA engine?
>
> Does it mean "SSI point of view" ?

I don't know.

> Then, YES

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
