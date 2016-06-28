From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Jun 2016 07:54:24 +0000
Subject: Re: [PATCH v3 19/19] sh: Renesas R0P751RLC0011RL (a.k.a R2Dplus) support
Message-Id: <CAMuHMdWBR+D_4v7E0Xm=vNVzCbqOJG-7KwK=Az9HPaQPZVe73A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp> <1467095795-5082-20-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-20-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jun 28, 2016 at 8:36 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../interrupt-controller/renesas-r2dplus.txt       | 41 ++++++++++
>  arch/sh/boot/dts/Makefile                          |  1 +
>  arch/sh/boot/dts/r2dplus.dts                       | 84 +++++++++++++++++++++
>  drivers/irqchip/Makefile                           |  2 +-
>  drivers/irqchip/irq-renesas-r2dplus.c              | 88 ++++++++++++++++++++++
>  5 files changed, 215 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas-r2dplus.txt
>  create mode 100644 arch/sh/boot/dts/r2dplus.dts
>  create mode 100644 drivers/irqchip/irq-renesas-r2dplus.c

Same comments as for landisk.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
