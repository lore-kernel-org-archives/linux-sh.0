From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Mar 2015 09:19:33 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <CAMuHMdVYUod+rqrjmvtwqT4dbJiGtt+qQW0CbRd5j6uGFJ3=gQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-3-git-send-email-geert+renesas@glider.be>
	<12083025.CFMfs0EISD@avalon>
In-Reply-To: <12083025.CFMfs0EISD@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Thu, Mar 5, 2015 at 10:03 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
>> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
>> @@ -69,9 +69,10 @@ struct pinmux_func {
>>  };
>>
>>  struct pinmux_cfg_reg {
>> -     unsigned long reg, reg_width, field_width;
>> +     unsigned long reg;
>
> How about making reg a u32 ? It won't make a difference in practice on 32-bit
> systems, but it would be more explicit.
>
> We could also save space by making reg a u16 and storing the register offset
> only instead of the full address (assuming it can always fit in 16 bits, which
> should be checked). We'll also need to support 64-bit systems at some point,
> and making reg a u64 would increase space waste.

That would be more intrusive (and definitely needs to be in a separate patch),
as reg is used here to store a physical register address, for conversion between
physical and virtual addresses. I didn't want to go that far yet.

u16 would indeed be nice, as it means reg, reg_width, and field_width
would fit in one 32-bit word, which I hadn't realized. That means we can reduce
each entry by 2 words instead of 1.

For 64-bit that would still be suboptimal, as pointers are aligned to 8 bytes,
leading to gaps.
Perhaps we do want __packed here, too? I don't think the performance drop of
doing some unaligned accesses would be significant. This isn't a hot path.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
