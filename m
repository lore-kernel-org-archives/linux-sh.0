From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Nov 2015 10:14:00 +0000
Subject: Re: [PATCH/RFC 0/4] pinctrl: sh-pfc: Add PINMUX_SINGLE()
Message-Id: <CAMuHMdWKcBbRwkgFxfatgPF2UFo2OTGAJ0wp3Q8sOGCXWB5SiA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
	<2326541.taAcxUkgxs@avalon>
In-Reply-To: <2326541.taAcxUkgxs@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Laurent,

On Wed, Nov 25, 2015 at 1:48 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 20 October 2015 21:26:31 Geert Uytterhoeven wrote:
>> Currently single-function pins are described using the raw PINMUX_DATA()
>> macro.
>>
>> Morimoto-san doesn't like that. He proposed to use the existing
>> PINMUX_IPSR_NOGP() macro instead (cfr. "[RFC] pinctrl: sh-pfc: r8a7795:
>> Add pinmux data for single-function pins",
>> http://www.spinics.net/lists/linux-sh/msg44823.html).
>> However, that macro is intended to describe a pinmux configuration
>> without GPIO function, which feels wrong to me.
>>
>> This patch series proposes an alternative, introducing a new macro
>> PINMUX_SINGLE() to describe a pinmux configuration for a single-function
>> pin. It also converts the existing single-function pin descriptions.
>>
>> Thanks for your comments!
>
> For patches 2-4,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

> But why haven't you included the other SoCs ?

Because this was an RFC. Didn't want to look for more occurrences if my RFC
was rejected.

Seems like there are indeed more possible users on emev2, r8a778, r8a7779,
and sh7734.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
