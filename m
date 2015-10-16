From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Oct 2015 15:04:43 +0000
Subject: Re: [PATCH v3 0/3] bockw SD pull-ups
Message-Id: <CAMuHMdWvBJWebWM0uZF4U9kqfTVDFcPfQ00GL-aXyjxPgCkAew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444056955-8836-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1444056955-8836-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Fri, Oct 16, 2015 at 4:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Oct 5, 2015 at 4:55 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>
>> This series implements pull-up configuration in the r8a7778 PFC driver
>> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
>> replacing the hack that is used in the legacy platforms.
>>
>> This version returns from the bias methods without doing any I/O if a pin
>> is undefined; thanks to Laurent for pointing this out.  It also includes
>> the various Acks.
>
> For all patches:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> I'm expecting Geert to accumulate this and send a pull request to me.

Will do next week.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
