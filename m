From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2014 10:04:32 +0000
Subject: Re: [PATCH 3/7] gpio: rcar: Add minimal runtime PM support
Message-Id: <CAMuHMdUcgYQ0E1NFozDK3=gxBWp9n+dLQFjt9cixvKkL4CJ7wg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395953262-4290-1-git-send-email-geert@linux-m68k.org>
	<1395953262-4290-4-git-send-email-geert@linux-m68k.org>
	<17238523.dCO4noXFe4@avalon>
In-Reply-To: <17238523.dCO4noXFe4@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Laurent,

On Fri, Mar 28, 2014 at 5:54 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -460,6 +464,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>> err1:
>>       irq_domain_remove(p->irq_domain);
>>  err0:
>> +     pm_runtime_put_sync(dev);
>
> Do we really need the sync version, isn't pm_runtime_put() enough ?

No we don't, copy-and-paste from rcar-thermal (which I'll fix, too).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
