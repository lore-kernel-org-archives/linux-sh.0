From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2015 08:11:49 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups
Message-Id: <CAMuHMdWEAND75h0Me2q=P=txQoPOA0AvNRV5XDjQEiUVE25SXA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Oct 30, 2015 at 8:55 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 29, 2015 at 08:57:34PM +0100, Geert Uytterhoeven wrote:
>> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>
>> Ensures that the pull-ups for pins SD0_CD and SD0_WP are enabled.
>>
>> This is one of two features from the DT reference platform that are
>> still missing in MP.
>>
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> The dependencies are now in pinctrl/for-next:
>> ae7465a0972aee88 pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
>> 22768fc60abbf58b pinctrl: sh-pfc: Add macros defining GP ports with config flags
>
> Am I correct in thinking that it is safe for me to apply this patch
> without those dependencies present in my dt-for-v4.5 branch?

Pinctrl may fail in that branch, and device probing may fail due to that
(still puzzled about when pinctrl failures are hard vs. soft).
But you will rebase the *-for-v4.5 branches on top of v4.4-rc1 later, right?
Then that problem will be resolved.

Note that not having this patch in v4.4 may be considered a regression
compared to bockw-legacy...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
