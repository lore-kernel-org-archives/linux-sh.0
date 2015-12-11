From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Dec 2015 03:54:28 +0000
Subject: Re: [PATCH v3 1/3] usb: renesas_usbhs: add SoC names to compatibility string documentation
Message-Id: <20151211035428.GA11940@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
 <1449799947-19866-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449799947-19866-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Dec 11, 2015 at 11:12:25AM +0900, Simon Horman wrote:
> This extends the documentation of compatibility strings a little to
> include the SoC names.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> v3
> * Split into separate patch
> ---
>  Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> index 7d48f63db44e..a14c0bb561d5 100644
> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
> @@ -2,10 +2,10 @@ Renesas Electronics USBHS driver
>  
>  Required properties:
>    - compatible: Must contain one of the following:
> -	- "renesas,usbhs-r8a7790"
> -	- "renesas,usbhs-r8a7791"
> -	- "renesas,usbhs-r8a7794"
> -	- "renesas,usbhs-r8a7795"
> +	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
> +	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
> +	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
> +	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
>    - reg: Base address and length of the register for the USBHS
>    - interrupts: Interrupt specifier for the USBHS
>    - clocks: A list of phandle + clock specifier pairs
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
