From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Dec 2015 12:39:09 +0000
Subject: Re: [PATCH] rcar_jpu: add fallback compatibility string
Message-Id: <5666CF6D.70802@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553349-20458-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449553349-20458-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 12/8/2015 8:42 AM, Simon Horman wrote:

> Add fallback compatibility string.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   Documentation/devicetree/bindings/media/renesas,jpu.txt | 13 +++++++------
>   drivers/media/platform/rcar_jpu.c                       |  1 +
>   2 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/media/renesas,jpu.txt b/Documentation/devicetree/bindings/media/renesas,jpu.txt
> index 0cb94201bf92..c96de75f0089 100644
> --- a/Documentation/devicetree/bindings/media/renesas,jpu.txt
> +++ b/Documentation/devicetree/bindings/media/renesas,jpu.txt
> @@ -5,11 +5,12 @@ and decoding function conforming to the JPEG baseline process, so that the JPU
>   can encode image data and decode JPEG data quickly.
>
>   Required properties:
> -  - compatible: should containg one of the following:
> -			- "renesas,jpu-r8a7790" for R-Car H2
> -			- "renesas,jpu-r8a7791" for R-Car M2-W
> -			- "renesas,jpu-r8a7792" for R-Car V2H
> -			- "renesas,jpu-r8a7793" for R-Car M2-N
> +- compatible: "renesas,jpu-<soctype>", "renesas,jpu" as fallback.

    Not "renesas,rcar[-gen2]-jpu"?

[...]

MBR, Sergei

