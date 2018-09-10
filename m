From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Sep 2018 10:02:43 +0000
Subject: Re: [PATCH] sh: mm: Use dma_zalloc_coherent instead of dma_alloc_coherent + memset
Message-Id: <CAMuHMdWxmUpw7M=qBtcELX67eSy7C-o_j8bdmozchi3YsRFTxg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1536548104-57453-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1536548104-57453-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: zhongjiang@huawei.com
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Robin Murphy <robin.murphy@arm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Sep 10, 2018 at 5:07 AM zhong jiang <zhongjiang@huawei.com> wrote:
> dma_zalloc_coherent has taken the dma_alloc_coherent() and memset() into
> account. Therefore, just use dma_zalloc_coherent to replace the open code.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
