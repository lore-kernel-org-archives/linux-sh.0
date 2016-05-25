From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 May 2016 13:24:51 +0000
Subject: Re: [PATCH] sh-sci: SysRq support on EARLYCON
Message-Id: <CAMuHMdVGimv1zAOqUCA95x2aGVHA=_LEnf-xWUp2jAK+kWHCaQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1461772153-6785-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1461772153-6785-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi Sato-san,

CC linux-serial

On Wed, Apr 27, 2016 at 5:49 PM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Add missing flag condition.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Unfortunately magic SysRq only works if CONFIG_SERIAL_SH_SCI_DMA=n.

> ---
>  drivers/tty/serial/sh-sci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 0130feb..5a73620 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -18,7 +18,9 @@
>   * License.  See the file "COPYING" in the main directory of this archive
>   * for more details.
>   */
> -#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#if (defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
> +     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)) && \
> +       defined(CONFIG_MAGIC_SYSRQ)
>  #define SUPPORT_SYSRQ
>  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
