From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2015 07:49:48 +0000
Subject: Re: [PATCH v2 2/4] pinctrl: sh-pfc: Use unsigned int for register/field widths and offsets
Message-Id: <CAMuHMdWxEVMnQYS0=vXbAkfUmypY934KcBegbXDXROgRL=MzVw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425985583-26279-1-git-send-email-geert+renesas@glider.be>
	<1425985583-26279-3-git-send-email-geert+renesas@glider.be>
	<1705055.eTGDDjPxdV@avalon>
In-Reply-To: <1705055.eTGDDjPxdV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Mar 12, 2015 at 2:00 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -322,13 +319,15 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned
>> mark, int pinmux_type) return -EINVAL;
>>       }
>>
>> -     pos = 0;
>> -     enum_id = 0;
>> -     field = 0;
>> -     value = 0;
>> -
>>       /* Iterate over all the configuration fields we need to update. */
>>       while (1) {
>> +             const struct pinmux_cfg_reg *cr = NULL;
>> +             unsigned int field = 0;
>> +             u16 enum_id = 0;
>> +             u32 value = 0;
>
> There's no need to initialize field, enum_id and value to 0 here.

And cr.

> With that fixed,

Will update and resend.

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
