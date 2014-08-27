From: Rob Herring <robherring2@gmail.com>
Date: Wed, 27 Aug 2014 17:08:50 +0000
Subject: Re: [PATCH 01/16] devicetree: Add vendor prefix "mitsubishi" to vendor-prefixes.txt
Message-Id: <CAL_JsqJgPJbz+v2FnTG=iW9q42SpWmhdREtwm1Eo-AJURgjvsQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1409157673-4154-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Aug 27, 2014 at 11:40 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Mitsubishi Electric Corporation has a numerical stock ticker, use the
> company name as vendor prefix.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..7292cfc 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -83,6 +83,7 @@ maxim Maxim Integrated Products
>  mediatek       MediaTek Inc.
>  micrel Micrel Inc.
>  microchip      Microchip Technology Inc.
> +mitsubishi     Mitsubishi Electric Corporation
>  mosaixtech     Mosaix Technologies, Inc.
>  moxa   Moxa
>  mpl    MPL AG
> --
> 1.8.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
