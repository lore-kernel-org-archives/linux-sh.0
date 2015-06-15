From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2015 12:40:46 +0000
Subject: Re: [PATCH 5/6][RFC] arm64: renesas: Add r8a7795 SoC support
Message-Id: <CAMuHMdUrt_5tph7hJ8s2xH_M+0YGXO7y_xAFkHvgXrA0KDMzwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 15, 2015 at 2:22 PM, Khiem Nguyen
<khiem.nguyen.xt@rvc.renesas.com> wrote:
>> +               /* 1core only at this point */
>> +               a53_0: cpu@100 {
>> +                       compatible = "arm,cortex-a53","arm,armv8";
>> +                       reg = <0x100>;
>> +                       device_type = "cpu";
>> +               };
>> +       };

>> +       gic: interrupt-controller@0xf1010000 {
>> +               compatible = "arm,gic-400", "arm,cortex-a15-gic";
>> +               #interrupt-cells = <3>;
>> +               #address-cells = <0>;
>> +               interrupt-controller;
>> +               reg = <0x0 0xf1010000 0 0x1000>,
>> +                     <0x0 0xf1020000 0 0x2000>;
>> +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) |
>> IRQ_TYPE_LEVEL_HIGH)>;
>
>
> Since there's only 1 CPU in this DTS, I guess the value should be 1, instead
> of 6.
> I remembered that Geert has a discussion thread about this matter. Geert ?

That's correct, cfr.
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/313194.html
which suggests the above was just copied from juno.dts.

However, as the single CPU in the dtsi is vpu@100, not cpu@0, I'm not sure
"GIC_CPU_MASK_SIMPLE(1)" is the right value anyway...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
