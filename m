From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2015 11:07:36 +0000
Subject: Re: [PATCH 3/3] spi: Re-do the returning value of qspi_transfer_out_in
Message-Id: <CAMuHMdVYnEiGaHzXFgH_pWmFRwWH91RQfm7RyS-XG9FvUTb_Mg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>
	<1430200551-20708-4-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1430200551-20708-4-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Apr 28, 2015 at 7:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>
> To reduce complex of code, drop "ret" then qspi_transfer_out_in function
> should be returned the value of "qspi_trigger_transfer_out_in" directly.
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
