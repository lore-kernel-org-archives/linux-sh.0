From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 08 Feb 2016 15:48:55 +0000
Subject: Re: [PATCH v3 1/2] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <CAMuHMdW_XbzfFcfRod4usntwgkg7-aYqUxvzXoNBOSegwa2E+Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890332-773-1-git-send-email-geert+renesas@glider.be>
	<1448890332-773-2-git-send-email-geert+renesas@glider.be>
	<4029813.xaXaFntOiW@avalon>
In-Reply-To: <4029813.xaXaFntOiW@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Laurent,

On Thu, Feb 4, 2016 at 7:43 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 30 November 2015 14:32:11 Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> v3:
>>   - Add Acked-by,
>>   - Document function names referring to IPSR fields,
>>   - Replace "configuration register" by more specific terms,
>>   - Rename "ms" to "msel" or "gsel",
>>   - EMEV2 PINMUX_IPSR_NOFN() pinmux configurations have a GPIO function,
>>
>> v2:
>>   - Clarify same width vs. different widths,
>>   - Mention GPSR for PINMUX_IPSR_DATA(),
>>   - Document NOGM (= NOGP + MSEL),
>>   - Fix s/ispr/ipsr/ typos.

[...]

> With those changes,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks a lot!

Will queue for next renesas-drivers and v4.6.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
