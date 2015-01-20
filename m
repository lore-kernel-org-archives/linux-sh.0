From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Jan 2015 09:42:48 +0000
Subject: Re: [GIT PULL] Second Round of Renesas ARM Based SoC Fixes for v3.19
Message-Id: <CAMuHMdVGv7O=dk6Ahoko4Go4K5_2YDRMqvxcCiJwc6KU2oGY=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421716614.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421716614.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 20, 2015 at 2:26 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Please consider these second round of Renesas ARM based SoC fixes for v3.19.
>
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-fixes-for-v3.19,
> which you have already pulled into your fixes branch.
>
> This fixes a regression in the r8a7779 and r8a7779 SoCs due to
> 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq domain.")
> which was included in v3.18-rc2.

Before people start backporting to -stable: it was introduced in v3.19-rc1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
