From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 Jan 2015 13:39:47 +0000
Subject: Re: [PATCH v4 2/3] ARM: shmobile: r8a7791: add CAN DT support
Message-Id: <CAMuHMdU-teLD-xLq4au=v-jNJoJ+kVxAxXZ0YjekS_HCQRiMQQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6830301.90YaDPuTpx@wasted.cogentembedded.com>
 <2080620.GIKTJkNfbk@wasted.cogentembedded.com>
 <CAMuHMdVuabRxKdpynaX0zaB-CvW8+dRb4TBtm7byT7znk6hxYQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVuabRxKdpynaX0zaB-CvW8+dRb4TBtm7byT7znk6hxYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 5, 2015 at 2:36 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> +               clocks = <&mstp9_clks R8A7791_CLK_RCAN0>,
>> +                        <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
>
> .git/rebase-apply/patch:18: space before tab in indent.
>       <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;

Sorry, my copy-'n-paste-foo has deteriorated over the holidays...

s/7790/7791/

>> +               clock-names = "clkp1", "clkp2", "can_clk";
>> +               status = "disabled";
>> +       };
>> +
>> +       can1: can@e6e88000 {
>> +               compatible = "renesas,can-r8a7791";
>> +               reg = <0 0xe6e88000 0 0x1000>;
>> +               interrupts = <0 187 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&mstp9_clks R8A7791_CLK_RCAN1>,
>> +                        <&cpg_clocks R8A7791_CLK_RCAN>, <&can_clk>;
>
> .git/rebase-apply/patch:28: space before tab in indent.
>       <&cpg_clocks R8A7790_CLK_RCAN>, <&can_clk>;

s/7790/7791/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
