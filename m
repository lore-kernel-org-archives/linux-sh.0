From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2015 09:44:31 +0000
Subject: Re: [PATCH 1/2] sh-pfc: r8a7791: fix typo in MLB_CLK
Message-Id: <CAMuHMdUWzfprPsDcjvtqFVm+THB_K1j3iuJjw6LY-VTHhzyk5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1479250.GJuNxlSkHs@wasted.cogentembedded.com>
In-Reply-To: <1479250.GJuNxlSkHs@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Sat, Jan 10, 2015 at 7:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The R8A7791 manual sometimes calls the signal MLB_CLK and sometimes MLB_CK; the
> latter can only be encountered in the PFC section and  is probably  just a typo
> (this  signal is always called MLB_CLK in the R8A7790  manual). Fix occurences
> of MLB_CK throughout the R8A7791 PFC driver.
>
> Based on original patch by Andrey Gusakov <andrey.gusakov@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, looks OK to me.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
