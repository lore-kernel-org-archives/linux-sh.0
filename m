From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 May 2020 06:54:02 +0000
Subject: Re: [PATCH v2] sh: Replace CONFIG_MTD_M25P80 with CONFIG_MTD_SPI_NOR in sh7757lcr_defconfig
Message-Id: <CAMuHMdXCvpLNAK3a4SsMt=TUsJAUBxO21X2sAsKiyBOgvLE+qg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1588417483-30987-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1588417483-30987-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bin Meng <bin.meng@windriver.com>

On Sat, May 2, 2020 at 1:06 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> From: Bin Meng <bin.meng@windriver.com>
>
> CONFIG_MTD_M25P80 was removed and replaced by CONFIG_MTD_SPI_NOR in
> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
