From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jul 2015 07:37:20 +0000
Subject: Re: [PATCH v3 1/3] sh-pfc: fix sparse GPIOs for R-Car SoCs
Message-Id: <CAMuHMdWPJ8B1-zETVvJUwh9+EYkjHi+s1qLURd_XVEHgFs2+ZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
	<2925145.E3lLFJfWJW@wasted.cogentembedded.com>
	<1756227.uoeezymTmX@avalon>
In-Reply-To: <1756227.uoeezymTmX@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Jul 7, 2015 at 7:39 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 26 June 2015 01:40:56 Sergei Shtylyov wrote:
>> The PFC driver causes the kernel to hang on the R-Car gen2 SoC based  boards
>> when the CPU_ALL_PORT() macro is fixed to reflect the reality, i.e. when
>> the GPIO space becomes actually sparse.  This happens because the
>> _GP_GPIO() macro includes  an indexed initializer which causes the "holes"
>> (array entries filled with all 0s) between the groups  of the existing
>> GPIOs; and the driver can't cope with that.  There seems to  be no reason
>> to use the indexed initializer, so we can remove the index specifier and so
>> avoid the "holes".
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> I initially thought that this patch looked too good to be true. The fix is so
> simple, there must have been a reason why _GP_GPIO used indexed initializers.
> I then tried to find that reason and failed.
>
> I still feel that this is too simple to be true, but I have no objective
> reason to push back, so

:-)

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> for the whole series, provided you have tested it, and paid attention to pins
> after the holes.

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
