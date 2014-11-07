From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Nov 2014 15:59:17 +0000
Subject: Re: [PATCH v4 0/6] sh73a0 common clock framework implementation
Message-Id: <CAMuHMdXkS=59gL-6O2bSrY-fFPNVS-Rb9e=fb61kRfF5yYchvg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Nov 7, 2014 at 4:07 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> On Fri, Nov 7, 2014 at 3:20 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> With this series applied (also with the previous version), kzm9g-multiplatform
>> (with sh73a0-kzm9g-reference.dtb) locks up after initializing ttySC4, i.e.
>> after printing
>>
>>     sh-sci e6c80000.serial: ttySC4 at MMIO 0xe6c80000 (irq = 110,
>> base_baud = 0) is a scifa
>>
>> If I comment out the "clocks" property of scifa4 in the dtsi, it continues
>> (without any serial output, of course).
>>
>> Do you have any clue?
>
> You might have better luck with the div6 patch applied as well. The
> upstream div6 driver resets the EXSRC bits when setting the divider,
> and IIRC that switches the parent of sub from extal2 to pll1_div2 on
> the kzm9g board. With the patch applied, the bits are preserved.

Right. After applying the div6 series, and a modified version of "ARM:
shmobile: sh73a0: add selectable sources to DIV6 clocks" (dropped
renesas,src-shift/renesas,src-width, padded clocks to 4 or 8 parents) it
works. Thanks!

kzm9g-multiplatform is getting in good shape now...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
