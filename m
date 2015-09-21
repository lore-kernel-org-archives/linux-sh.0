From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2015 11:45:20 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a779[01]: move 'union vin_data' to shared header file
Message-Id: <CAMuHMdUDvE0KgR-co50D+Z37i4a9U7kKtqqg-BESOPWMFoOsUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<4177542.1tOnYXlTVP@wasted.cogentembedded.com>
In-Reply-To: <4177542.1tOnYXlTVP@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Aug 28, 2015 at 10:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> R8A7790/1 PFC  drivers use almost identical  'union vin_data' and completely
> identical VIN_DATA_PIN_GROUP() macro; we thus can  move them into the shared
> header file...
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
