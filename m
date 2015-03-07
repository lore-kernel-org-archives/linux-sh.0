From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:06:15 +0000
Subject: Re: [PATCH 11/11] PCI: rcar: document r8a7793 DT bindings
Message-Id: <20150307000615.GD19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-12-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-12-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2015 at 06:09:58PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> index d8ef5bf..8b156fe 100644
> --- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> @@ -8,6 +8,7 @@ OHCI and EHCI controllers.
>  Required properties:
>  - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
>  	      "renesas,pci-r8a7791" for the R8A7791 SoC.
> +	      "renesas,pci-r8a7793" for the R8A7793 SoC.
>  - reg:	A list of physical regions to access the device: the first is
>  	the operational registers for the OHCI/EHCI controllers and the
>  	second is for the bridge configuration and control registers.
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
