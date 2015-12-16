From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Dec 2015 10:28:11 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7795: Add SDHI support
Message-Id: <CAMuHMdW-hFRduFoXHos=ngSfMWrZm2JokY6QnVjWkmj8qZ-JTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441219822-28863-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441219822-28863-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dirk,

On Thu, Dec 10, 2015 at 6:07 PM, Dirk Behme <dirk.behme@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Add SDHI[0-3] pinmux support to r8a7795 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you, queued for v4.5.

> ---
> Note: This patch is picked from
>
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/log/?h=v4.2/rcar-3.0.x
>
> and rebased against
>
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/gen3-latest renesas-drivers-2015-12-08-v4.4-rc4
>
> Changes in v2:
>
> Rebased against renesas-drivers-2015-12-08-v4.4-rc4 dropping the parts already added by
>
> [PATCH v2 1/2] pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function
> pins" (http://www.spinics.net/lists/linux-gpio/msg09960.html).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
