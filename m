From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Nov 2015 10:44:51 +0000
Subject: Re: [PATCH/RFC 1/4] pinctrl: sh-pfc: Add PINMUX_SINGLE()
Message-Id: <CAMuHMdU9E4X13i9j6SO-WQeJ0qx=gDt3GQ6iD72hpcA+jJsz8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
	<1445369195-25117-2-git-send-email-geert+renesas@glider.be>
	<3546719.xIF05iocVT@avalon>
In-Reply-To: <3546719.xIF05iocVT@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Laurent,

On Wed, Nov 25, 2015 at 1:49 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 20 October 2015 21:26:32 Geert Uytterhoeven wrote:
>> Add a macro to describe a pinmux configuration for a single-function
>> pin.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/pinctrl/sh-pfc/sh_pfc.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
>> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 63e6cd050d0fb7d2..932fbef8bad400dd
>> 100644
>> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
>> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
>> @@ -277,6 +277,13 @@ struct sh_pfc_soc_info {
>>       PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
>>
>>  /*
>> + * Describe a pinmux configuration for a single-function pin.
>
> I would say "single-function pin with GPIO capability".

OK, makes sense, so will update.

Note that there's usually an exception to every rule ("PENC1" on r8a7779 ;-).

> Apart from that,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
