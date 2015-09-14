From: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Date: Mon, 14 Sep 2015 09:22:30 +0000
Subject: Re: [PATCH] [media] VIDEO_RENESAS_JPU should depend on HAS_DMA
Message-Id: <CALi4nhoZZGeQHww8tqip2HuoaFUzd9c4mR=v3HdNK1nh86UzdQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441534308-24662-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1441534308-24662-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!
Thanks for patch.

On Sun, Sep 6, 2015 at 1:11 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> If NO_DMA=y:
>
>     warning: (VIDEO_STI_BDISP && VIDEO_RENESAS_JPU && VIDEO_DM365_VPFE && VIDEO_OMAP4) selects VIDEOBUF2_DMA_CONTIG which has unmet direct dependencies (MEDIA_SUPPORT && HAS_DMA)
>
>     drivers/media/v4l2-core/videobuf2-dma-contig.c: In function ‘vb2_dc_mmap’:
>     drivers/media/v4l2-core/videobuf2-dma-contig.c:207: error: implicit declaration of function ‘dma_mmap_coherent’
>     drivers/media/v4l2-core/videobuf2-dma-contig.c: In function ‘vb2_dc_get_base_sgt’:
>     drivers/media/v4l2-core/videobuf2-dma-contig.c:390: error: implicit declaration of function ‘dma_get_sgtable’
>
> VIDEO_RENESAS_JPU selects VIDEOBUF2_DMA_CONTIG, which bypasses its
> dependency on HAS_DMA.  Make VIDEO_RENESAS_JPU depend on HAS_DMA to fix
> this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index dc75694ac12d2d57..ccbc9742cb7aeca4 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -233,7 +233,7 @@ config VIDEO_SH_VEU
>
>  config VIDEO_RENESAS_JPU
>         tristate "Renesas JPEG Processing Unit"
> -       depends on VIDEO_DEV && VIDEO_V4L2
> +       depends on VIDEO_DEV && VIDEO_V4L2 && HAS_DMA
>         depends on ARCH_SHMOBILE || COMPILE_TEST
>         select VIDEOBUF2_DMA_CONTIG
>         select V4L2_MEM2MEM_DEV
> --
> 1.9.1
>

Acked-by: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>



-- 
W.B.R, Mikhail.
