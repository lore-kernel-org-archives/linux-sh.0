From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2015 09:30:54 +0000
Subject: Re: Possible regression in next-20150310 due to pinctrl: sh-pfc: r8a7790: Remove non existing GPIO p
Message-Id: <CAMuHMdUOScAQCBG1GM=d8mZj1PDDkZd9Pfxps=-814=rFAyAfQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150310075538.GA20709@verge.net.au>
In-Reply-To: <20150310075538.GA20709@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>

Hi Simon,

On Tue, Mar 10, 2015 at 8:55 AM, Simon Horman <horms@verge.net.au> wrote:
> I have observed what appears to be a regression in next-20150310.  Using
> the shmobile_defconfig the lager board does not produce console output
> whatsoever. If I revert bfb6698fad74e7ba2 ("pinctrl: sh-pfc: r8a7790:
> Remove non existing GPIO pins") then the problem seems to be resolved.
>
> Likewise for the koelsh board and 896498d439cec6ff0 ("pinctrl: sh-pfc:
> r8a7791: Remove non existing GPIO pins").

That's correct. I reverted these in renesas-drivers-2015-03-09-v4.0-rc3.

In the mean time, they have been dropped from pinctrl/for-next, as
requested by Laurent last week.

Sorry for the issues.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
