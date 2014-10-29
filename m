From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2014 09:59:48 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <CAMuHMdVccy_i2EuSP_3cME9jAaFo8zj2Q54dDQ=rByJ5gJ0=_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Oct 29, 2014 at 10:49 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> I've performed quick SDHI performance tests yesterday. Read performance were
> around 7.5% lower with DMA support. Write performances varied but seemed
> similar on average.
>
> - PIO
>
> # time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
> 262144+0 records in
> 262144+0 records out

262144 records? Did it get split in 512 byte records?

> # time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
> 32+0 records in
> 32+0 records out

Only 32 records?

> - DMA
>
> # time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
> 32+0 records in
> 32+0 records out

Only 32 records?

> # time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
> 32768+0 records in
> 32768+0 records out

OK

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
