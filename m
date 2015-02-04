From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 04 Feb 2015 09:02:54 +0000
Subject: Re: [PATCH] sh-pfc: emev2 - Fix mangled author name
Message-Id: <CAMuHMdU=T4jhhcoJJBp2CTsup3kz+Vzm_Vc5X1H+xZO6=Vk_JA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422526376-12146-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdaY+fiYMt4MGQFTdyRAMXnhNj6tJQckst5ECrKREOQ6gw@mail.gmail.com>
In-Reply-To: <CACRpkdaY+fiYMt4MGQFTdyRAMXnhNj6tJQckst5ECrKREOQ6gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niso@kth.se>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Linus,

On Wed, Feb 4, 2015 at 9:54 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jan 29, 2015 at 11:12 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Fixes: 1e7d5d849cf4f0c5 ("sh-pfc: Add emev2 pinmux support")
>> ---
>> Looks like the original UTF-8 was interpreted as ISO-8859-1, and the
>> resulting characters being converted to UTF-8 again.
>>
>> BTW, the same issue is present in the SoB-lines of both
>> 1e7d5d849cf4f0c5 ("sh-pfc: Add emev2 pinmux support") and
>> 4c9e473541c52453 ("sh-pfc: add macro to define pinmux without function")
>> Perhaps they can still be fixed while squashing this in?
>
> This is painful, your patch arrives with this header:
>
> Content-Type: text/plain; charset=y
> Content-Transfer-Encoding: 8bit
>
> When I try to apply it git am says:
>
> $ git am --signoff geert1.patch
> fatal: cannot convert from y to UTF-8
>
> Wut? I never heard of an encoding named "y", and SMTP is
> not my strongest subject anyway.

Oops, I'm afraid automatic-I replied "y" to the git-send-email question
"Which 8bit encoding should I declare [UTF-8]?"
(happened before with the In-Reply-To questions ;-(

Sorry, resent by private email...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
