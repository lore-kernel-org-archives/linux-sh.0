From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Mar 2015 09:34:18 +0000
Subject: Re: [PATCH 4/4] pinctrl: sh-pfc: Use unsigned int for register/field widths and offsets
Message-Id: <CAMuHMdWk-XWJz9PswNfkyG6yKctH0Jnf7uPLZ8i1X_umhbO+sA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-5-git-send-email-geert+renesas@glider.be>
	<9833485.4LcIhc9qJb@avalon>
In-Reply-To: <9833485.4LcIhc9qJb@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Thu, Mar 5, 2015 at 10:20 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -228,12 +228,11 @@ static void sh_pfc_write_config_reg(struct sh_pfc
>> *pfc, }
>>
>>  static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
>> -                              const struct pinmux_cfg_reg **crp, int *fieldp,
>> -                              u32 *valuep)
>> +                              const struct pinmux_cfg_reg **crp,
>> +                              unsigned int *fieldp, u32 *valuep)
>>  {
>>       const struct pinmux_cfg_reg *config_reg;
>> -     unsigned long r_width, f_width, curr_width;
>> -     unsigned int k, m, pos, bit_pos;
>> +     unsigned int r_width, f_width, curr_width, k, m, pos, bit_pos;
>
> I find declaring multiple variables per line quite difficult to read. I know
> it's the current coding style in this driver, but I'd like to fix it at some
> point. I would move to one variable per line as part of this patch for the
> code that it touches. Alternatively could you at least not make it worse (here
> and below) ? :-)

There are just too many variables ;-)

I usually declare variables in the order of appearance, but try to
keep variables
of the same type together.

Some declarations could move inside the while, e.g.

        while (1) {
                const struct pinmux_cfg_reg *config_reg pfc->info->cfg_regs + k;
                unsigned int r_width = config_reg->reg_width;
                unsigned int f_width = config_reg->field_width;
                unsigned int pos = 0, m= 0;

                if (!r_width)
                        break;

Would you like that?

>>       u32 ncomb, n;
>>
>>       k = 0;
>> @@ -300,9 +299,9 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark,
>> int pinmux_type) const struct pinmux_cfg_reg *cr = NULL;
>>       u16 enum_id;
>>       const struct pinmux_range *range;
>> -     int in_range, pos, field;
>> +     int in_range, pos, ret;
>> +     unsigned int field;
>>       u32 value;
>> -     int ret;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
