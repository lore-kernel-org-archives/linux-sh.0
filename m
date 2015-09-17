From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 08:46:19 +0000
Subject: Re: [PATCH 11/20 v2] arm64: renesas: add AUDIO_DMAC support
Message-Id: <CAMuHMdVO7DHgfSc9z2s6gKkOgZnaKSX_+GTBCpPtS4FpZ4ZQgQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9mt7jug.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9mt7jug.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 17, 2015 at 7:28 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
> (snip)
>> +             audma0: dma-controller@ec700000 {
>> +                     compatible = "renesas,rcar-dmac";
>> +                     reg = <0 0xec700000 0 0x10000>;
>> +                     interrupts =    <0 350 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 320 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 321 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 322 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 323 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 324 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 325 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 326 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 327 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 328 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 329 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 330 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 331 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 332 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 333 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 334 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 335 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupt-names = "error",
>> +                                     "ch0", "ch1", "ch2", "ch3",
>> +                                     "ch4", "ch5", "ch6", "ch7",
>> +                                     "ch8", "ch9", "ch10", "ch11",
>> +                                     "ch12", "ch13", "ch14", "ch15";
>> +                     clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC0>;
>> +                     clock-names = "fck";
>> +                     #dma-cells = <1>;
>> +                     dma-channels = <16>;
>> +             };
>> +
>> +             audma1: dma-controller@ec720000 {
>> +                     compatible = "renesas,rcar-dmac";
>> +                     reg = <0 0xec720000 0 0x10000>;
>> +                     interrupts =    <0 351 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 336 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 337 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 338 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 339 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 340 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 341 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 342 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 343 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 344 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 345 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 346 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 347 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 348 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 349 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 382 IRQ_TYPE_LEVEL_HIGH
>> +                                      0 383 IRQ_TYPE_LEVEL_HIGH>;
>> +                     interrupt-names = "error",
>> +                                     "ch0", "ch1", "ch2", "ch3",
>> +                                     "ch4", "ch5", "ch6", "ch7",
>> +                                     "ch8", "ch9", "ch10", "ch11",
>> +                                     "ch12", "ch13", "ch14", "ch15";
>> +                     clocks = <&mstp5_clks R8A7795_CLK_AUDIO_DMAC1>;
>> +                     clock-names = "fck";
>> +                     #dma-cells = <1>;
>> +                     dma-channels = <16>;
>> +             };
>
> I noticed these are missing
>
>                 power-domains = <&cpg_clocks>;

After you've add those:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
