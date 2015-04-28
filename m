From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2015 11:07:18 +0000
Subject: Re: [PATCH 2/3] spi: modify the name of qspi_trigger_transfer_out_int function
Message-Id: <CAMuHMdUCvidoXs05+63uUFyoGM2DFJ6xz0w1Ujr1Xjv9EiEAJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>
	<1430200551-20708-3-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1430200551-20708-3-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Apr 28, 2015 at 7:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>
> The name of "qspi_trigger_transfer_out_int" function should be
> "qspi_trigger_transfer_out_in" without "t".
>
> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
