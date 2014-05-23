From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 May 2014 06:55:23 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7779 dtsi: Correct #address-cells/#size-cells for clocks
Message-Id: <CAMuHMdUTe5AfGPNZeVApzBr-6xNofutA_BOfQG+xN3aQeZvWPA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
 <1400761997-13512-2-git-send-email-geert+renesas@glider.be>
 <155646478.xj0lyDQ1cd@avalon>
In-Reply-To: <155646478.xj0lyDQ1cd@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Fri, May 23, 2014 at 1:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> -             cpg_clocks: cpg_clocks@0xe6150000 {
>> +             cpg_clocks: cpg_clocks@0xffc80000 {
>
> No need for a 0x prefix.

Thanks, missed that one.

>>                       compatible = "renesas,r8a7779-cpg-clocks";
>> -                     reg = <0 0xffc80000 0 0x30>;
>> +                     reg = <0xffc80000 0x30>;
>
> This looks good.
>
>>                       clocks = <&extal_clk>;
>>                       #clock-cells = <1>;
>>                       clock-output-names = "plla", "z", "zs", "s",
>> @@ -342,10 +342,10 @@
>>               };
>>
>>               /* Gate clocks */
>> -             mstp0_clks: mstp0_clks {
>> +             mstp0_clks: mstp0_clks@ffc80030 {
>
> The @address is only mandatory to differentiate between nodes with identical
> names. As the node name is supposed to describe the device function, maybe we
> could rename it to clocks@ffc80030 ? As you modify the CPG node address above
> it might make sense to rename it to clocks@ffc80000 too.

Sounds good!

> I'm not advocating for a rename now, but as your patch touches the names, I
> think they should be fixed properly (or not at all).

In hindsight, I should have separated the fix and the "obvious small things",
as the latter are subject to bike-shedding ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
