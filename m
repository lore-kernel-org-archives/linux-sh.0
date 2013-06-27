From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Jun 2013 13:04:45 +0000
Subject: Re: [PATCH 02/24] drm/rcar-du: Use devm_ioremap_resource()
Message-Id: <51CC386D.30309@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1372326574-4315-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hello.

On 27-06-2013 13:49, Laurent Pinchart wrote:

> Replace the devm_request_mem_region() and devm_ioremap_nocache() calls
> with devm_ioremap_resource().

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/gpu/drm/rcar-du/rcar_du_drv.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)

> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 003b34e..24ab0ca 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
[...]
> @@ -129,24 +128,9 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
>
>   	/* I/O resources and clocks */
>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
[...]
> +	rcdu->mmio = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(rcdu->mmio))
>   		return -ENOMEM;

    You should return PTR_ERR(rcdu->mmio).

WBR, Sergei

