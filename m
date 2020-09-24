From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Sep 2020 07:33:05 +0000
Subject: Re: [PATCH] sh: remove CONFIG_IDE from most defconfig
Message-Id: <CAMuHMdVxZbNfBHyabaBReH3O7q5xB42+3g78A52xZBtxJzyRYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200924043139.522028-1-hch@lst.de>
In-Reply-To: <20200924043139.522028-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Christoph,

On Thu, Sep 24, 2020 at 6:31 AM Christoph Hellwig <hch@lst.de> wrote:
> Remove CONFIG_IDE from defconfigs that did not actually select chipset
> drivers, and switch ones that have libata drivers to libata.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/arch/sh/configs/landisk_defconfig
> +++ b/arch/sh/configs/landisk_defconfig
> @@ -27,13 +27,12 @@ CONFIG_NETFILTER=y
>  CONFIG_ATALK=m
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
> -CONFIG_BLK_DEV_OFFBOARD=y
> -CONFIG_BLK_DEV_GENERIC=y
> -CONFIG_BLK_DEV_AEC62XX=y
> +CONFIG_ATA=y
> +CONFIG_ATA_GENERIC=y
> +CONFIG_PATA_ATP867X=y

Landisk should also have

    +CONFIG_PATA_PLATFORM=y

but as it didn't have CONFIG_BLK_DEV_PLATFORM=y before neither,
probably that should be a separate patch anyway?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
