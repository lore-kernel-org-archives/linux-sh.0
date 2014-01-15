From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jan 2014 08:28:29 +0000
Subject: Re: [PATCH 1/2] ARM: dts: r8a7790: Add SATA nodes to r8a7790.dtsi
Message-Id: <CAMuHMdVXbXRWELKih9Yh0Uk7J7-LquL3oYpkNTOjqoNPSt0zvQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 15, 2014 at 1:02 AM, Simon Horman <horms@verge.net.au> wrote:
>> >>+   sata0: sata@ee300000 {
>> >>+           compatible = "renesas,sata-r8a7790";
>> >>+           reg = <0 0xee300000 0 0x2000>;
>> >>+           interrupt-parent = <&gic>;
>> >>+           interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
>> >>+           clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
>> >
>> >If I'm not mistaken the RCar SATA DT bindings don't document the clocks
>> >property.
>>
>> Yes, they don't, cause at that time the clocks were not supported.
>>
>> >Could you please submit a patch to fix that ?
>>
>> I could, but the patch that adds the description is still available only
>> in the for-3.14 branch of the libata repo.
>
> I think you could provide a patch to update the bindings (documentation),
> which is not part of this series, which applies to that branch.

As this also applies to SPI...

Just "clocks: Must contain a phandle and clock-specifier pair"?

And should this be marked as optional, as e.g. r7s72100genmai doesn't have
mstp clocks in DT yet?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
