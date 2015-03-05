From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Mar 2015 09:28:13 +0000
Subject: Re: [PATCH 3/4] pinctrl: sh-pfc: Use u32 to store register data
Message-Id: <CAMuHMdUcA6CW_7nVh5yUCnoUVGi-D91sj=zew5nG95bVDhADDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-4-git-send-email-geert+renesas@glider.be>
	<2378036.Aimhfrhzzn@avalon>
In-Reply-To: <2378036.Aimhfrhzzn@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Thu, Mar 5, 2015 at 10:14 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -230,11 +229,12 @@ static void sh_pfc_write_config_reg(struct sh_pfc
>> *pfc,
>>
>>  static int sh_pfc_get_config_reg(struct sh_pfc *pfc, u16 enum_id,
>>                                const struct pinmux_cfg_reg **crp, int *fieldp,
>> -                              int *valuep)
>> +                              u32 *valuep)
>>  {
>>       const struct pinmux_cfg_reg *config_reg;
>> -     unsigned long r_width, f_width, curr_width, ncomb;
>> -     unsigned int k, m, n, pos, bit_pos;
>> +     unsigned long r_width, f_width, curr_width;
>> +     unsigned int k, m, pos, bit_pos;
>> +     u32 ncomb, n;
>
> Nitpicking, strictly speaking ncomb and n are not register data, but using u32
> for them seems good to me.

n is assigned to the (partial) register value output parameter, so it is.
ncomb is an upper boundary for n.

And I didn't want to split this off to yet another patch ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
