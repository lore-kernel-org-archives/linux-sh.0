From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Sun, 20 Jan 2019 13:20:24 +0000
Subject: Re: [PATCH] arch/sh/mm/consistent.c: Use dma_zalloc_coherent
Message-Id: <CAFqt6zYkgrUgtFQbc-W=Jap84wshPSH5aTRTBfsRkOQhaSROdQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
In-Reply-To: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, thomas.petazzoni@free-electrons.com, robin.murphy@arm.com, jacopo+renesas@jmondi.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Brajeswar Ghosh <brajeswar.linux@gmail.com>

On Sun, Oct 28, 2018 at 12:29 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherant
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/sh/mm/consistent.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 792f361..fc8d235 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -52,13 +52,12 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
>         if (!memsize)
>                 return 0;
>
> -       buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
> +       buf = dma_zalloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
>         if (!buf) {
>                 pr_warning("%s: unable to allocate memory\n", name);
>                 return -ENOMEM;
>         }
>
> -       memset(buf, 0, memsize);
>
>         r->flags = IORESOURCE_MEM;
>         r->start = dma_handle;
> --
> 2.7.4
>
