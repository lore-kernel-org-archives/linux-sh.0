From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Feb 2015 11:18:29 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7794: add SDHI DT support
Message-Id: <CAMuHMdUtWmTB7yUfJfAjc7T9tAx+bz1u_ZGi6gBcyEhfBfb0Qg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <4571288.SFHfW35Ob9@wasted.cogentembedded.com>
 <87oaolpj0c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oaolpj0c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Morimoto-san,

On Mon, Feb 23, 2015 at 1:28 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> +     sdhi0: sd@ee100000 {
>> +             compatible = "renesas,sdhi-r8a7794";
>> +             reg = <0 0xee100000 0 0x200>;
>> +             interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&mstp3_clks R8A7794_CLK_SDHI0>;
>> +             status = "disabled";
>> +     };
>> +
>> +     sdhi1: sd@ee140000 {
>> +             compatible = "renesas,sdhi-r8a7794";
>> +             reg = <0 0xee140000 0 0x100>;
>> +             interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&mstp3_clks R8A7794_CLK_SDHI1>;
>> +             status = "disabled";
>> +     };
>> +
>> +     sdhi2: sd@ee160000 {
>> +             compatible = "renesas,sdhi-r8a7794";
>> +             reg = <0 0xee160000 0 0x100>;
>> +             interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
>> +             clocks = <&mstp3_clks R8A7794_CLK_SDHI2>;
>> +             status = "disabled";
>> +     };
>
> This patch and r8a7791.dtsi have sdhi0/1/2.
> But, according to datasheet, it is sdhi0/2/3.
> (Only R-Car H2 have sdhi1)

There's a difference between the SDHI clocks and the SDHI instances
(and their MSTP clocks). Cfr. the discussion
"ARM: shmobile: r8a7794: Correct SDHI base address, clock labels and
 output-names".

> I don't care so match about this, but
> I think following datasheet is no-confusion if possible.

Please check the naming on pages 59-2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
