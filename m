From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:42:06 +0000
Subject: Re: [PATCH 1/7] ARM: shmobile: r8a73a4 dtsi: Add missing "gpio-ranges" to gpio node
Message-Id: <CACRpkdbB6mLZAxpvPq8X5cWVLYD05ruF2XbwZSYn16Kj8tXvdQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
 <1435650327-2542-2-git-send-email-geert+renesas@glider.be>
 <32630741.rNENluEsDE@avalon>
 <CAMuHMdX4=C6DsbsaphndXQuPm8WFqv08kwq+cdQRJJQtDph1cg@mail.gmail.com>
In-Reply-To: <CAMuHMdX4=C6DsbsaphndXQuPm8WFqv08kwq+cdQRJJQtDph1cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 14, 2015 at 2:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Jun 30, 2015 at 11:49 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:

>>> To fix this, add a "gpio-ranges" property to the gpio device node, so
>>> the ranges are added by of_gpiochip_add_pin_range(), which is called by
>>> of_gpiochip_add() before the call to of_gpiochip_scan_hogs().
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> This looks sane to me, even though referencing the same DT node seems a bit
>> dodgy. I'll let Linus comment on that, but for the implementation itself,
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Thank you!
>
> Any wise words from Linus?

I don't know if I'm wise but I'm OK with this:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
