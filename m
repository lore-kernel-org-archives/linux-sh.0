From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jan 2014 08:31:17 +0000
Subject: Re: [PATCH v2 0/8] SoC and board integration for RSPI on RZ/A1H
Message-Id: <CAMuHMdW5e74keNhRkSG6q6crGWZ0Gqtb5-hntbCUNm7Md78Bcw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <20140107012628.GD2196@verge.net.au>
In-Reply-To: <20140107012628.GD2196@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 7, 2014 at 2:26 AM, Simon Horman <horms@verge.net.au> wrote:
>>     [1/8] pinctrl: sh-pfc: r7s72100: Add RSPI support
>
> I believe that Laurent should handle this.

Don't you mean Magnus? This is RZ/A1H, not R-Car.

>>     [2/8] ARM: shmobile: r7s72100: Add RSPI clocks
>
> This seems fine and independent of the other patches.
> But unfortunately it no longer applies.
>
> Feel free to rebase it if you would like me to queue it up sooner
> than later.

Will do.

>>     [3/8] ARM: shmobile: r7s72100: Add RSPI platform devices
>
> I assume this depends on 1/3.

1/8? Or are you mixing up with 1/3 for Koelsch?

Nevertheless, this just adds platform devices, so it should be fairly
independent.

> Please add a patch to update the koelsch defconfig.

Genmai defconfig, not koelsch.

>>     [4/8] ARM: shmobile: genmai: Add RSPI children (NEW)
>
> This seems reasonable but I assume it depends on earlier patches.

Yes, it's useless without 3/8. But I guess it will just fail to find the
SPI bus.

> Please add a patch to update the koelsch defconfig or Kconfig.

Genmai ;-) Will do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
