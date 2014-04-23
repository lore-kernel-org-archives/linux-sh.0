From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2014 07:13:30 +0000
Subject: Re: [PATCH v2 2/6] gpio: rcar: Add minimal runtime PM support
Message-Id: <CAMuHMdX9oQwjtJi2KYYj8D7KjHh_y5OVOYmgN8K1mOnYQLon-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
	<1397500397-12607-3-git-send-email-geert@linux-m68k.org>
	<CACRpkdbfKmpykqZGj64QzZ-FAq+vXC5DbhOiL=iDvbt6U8U8yw@mail.gmail.com>
In-Reply-To: <CACRpkdbfKmpykqZGj64QzZ-FAq+vXC5DbhOiL=iDvbt6U8U8yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Linus,

On Wed, Apr 23, 2014 at 9:03 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Apr 14, 2014 at 8:33 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> This is just enough to automatically enable the functional clock, if
>> present. Clock management during suspend/resume is still to be added.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
>> Cc: linux-gpio@vger.kernel.org
>> ---
>> v2:
>>   - Use pm_runtime_put() instead of pm_runtime_put_sync()
>
> This v2 version applied with Laurent's ACK. I guess you wanted it
> applied to the GPIO tree, I don't see the other patches.

Thanks, yes that was the idea.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
