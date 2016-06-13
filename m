From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2016 08:05:57 +0000
Subject: Re: [PATCH v2 10/17] sh: convert generic drivers framework
Message-Id: <CAMuHMdWMreEye+jLeXkKgh8Qthq4E28OSg2KkE7siWf7F42+=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp> <1465714475-24111-11-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-11-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>

On Sun, Jun 12, 2016 at 8:54 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> index 0000000..89e28d8
> --- /dev/null
> +++ b/drivers/clk/sh/Kconfig
> @@ -0,0 +1,2 @@
> +config COMMON_CLK_SH7750
> +       bool "Clcok driver for SH7750/SH7751"

Clock

> diff --git a/drivers/clk/sh/Makefile b/drivers/clk/sh/Makefile
> new file mode 100644
> index 0000000..468eb9d
> --- /dev/null
> +++ b/drivers/clk/sh/Makefile
> @@ -0,0 +1,2 @@
> +obj-y += clk-shdiv.o
> +obj-$(CONFIG_COMMON_CLK_SH7750) += clk-sh7750.o
> \ No newline at end of file

Please add the newline.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
