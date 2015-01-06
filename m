From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 Jan 2015 10:22:02 +0000
Subject: Re: [PATCH] spi: sh-msiof: fix MDR1_FLD_MASK value
Message-Id: <CAMuHMdV0ikyp2n9rVa7jLXM_eLSnbRp1o4_j2MZHGkXcKLaBgQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1420538486-1420-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Shimoda-san,

On Tue, Jan 6, 2015 at 11:01 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the FLD bit field is bit[3:2], the MDR1_FLD_MASK value should
> be 0x0000000c.

Thanks, my mistake. Fortunately the definition is not used.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
