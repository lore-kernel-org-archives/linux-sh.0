From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jul 2015 07:38:30 +0000
Subject: Re: [PATCH v3 3/3] sh-pfc: r8a7791: remove non-existing GPIO pins
Message-Id: <CAMuHMdWK=42TXv8213kjPxAXMB+wDtnOTOOhyD65-cs8ncV_1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
	<1503001.TnFHhSFjY8@wasted.cogentembedded.com>
In-Reply-To: <1503001.TnFHhSFjY8@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Jun 26, 2015 at 12:43 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> GPIO banks 1 and 7 are missing pins 26 to 31. Remove them.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On r8a7791/koelsch, the switches (gpio banks 5 and 7) and LEDs (gpio bank 2)
still work, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
