From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Mar 2015 18:02:10 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <CAMuHMdXNEcrtYge=EcNhAXnm8367h7=7SAg0AkiE1gvSJTxJpw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-3-git-send-email-geert+renesas@glider.be>
	<12083025.CFMfs0EISD@avalon>
	<CAMuHMdVYUod+rqrjmvtwqT4dbJiGtt+qQW0CbRd5j6uGFJ3=gQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVYUod+rqrjmvtwqT4dbJiGtt+qQW0CbRd5j6uGFJ3=gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Thu, Mar 5, 2015 at 10:19 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Mar 5, 2015 at 10:03 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
>>> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
>>> @@ -69,9 +69,10 @@ struct pinmux_func {
>>>  };
>>>
>>>  struct pinmux_cfg_reg {
>>> -     unsigned long reg, reg_width, field_width;
>>> +     unsigned long reg;
>>
>> How about making reg a u32 ? It won't make a difference in practice on 32-bit
>> systems, but it would be more explicit.
>>
>> We could also save space by making reg a u16 and storing the register offset
>> only instead of the full address (assuming it can always fit in 16 bits, which
>> should be checked). We'll also need to support 64-bit systems at some point,

Unfortunately there's a (single) exception: sh7734 has two register blocks, at
0xFFFC0000 and 0xFFC40000, which is more than 64 KiB apart.
And we also can't say that all config registers are in the first
block, and all data
registers are in the second block (for SoCs with multiple blocks).

We could use u32 instead of u16 if CONFIG_PINCTRL_PFC_SH7734 is set, though.

>> and making reg a u64 would increase space waste.
>
> That would be more intrusive (and definitely needs to be in a separate patch),
> as reg is used here to store a physical register address, for conversion between
> physical and virtual addresses. I didn't want to go that far yet.

I had a quick check, and using 16-bit register offsets instead of 32-bit
registers addresses would save ca. 3 KiB in a shmobile_defconfig kernel.
Which is a saving of less than 2% of the current pinctrl binary size.

Of course it's something to keep in mind for future 64-bit SoCs...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
