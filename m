From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 02 Jun 2014 13:50:40 +0000
Subject: Re: [PATCH v2 2/7] DMA: shdma: Spelling s/controll/control/
Message-Id: <538C8130.8050601@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1401716531-29794-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 02/06/14 14:42, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New
> 
>  Documentation/devicetree/bindings/dma/shdma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
> index d26b7065ae94..2b61cab0525c 100644
> --- a/Documentation/devicetree/bindings/dma/shdma.txt
> +++ b/Documentation/devicetree/bindings/dma/shdma.txt
> @@ -73,7 +73,7 @@ Example:
>  	};
>  
>  For r8a7790 and newer implementations, the information for the channel
> -controll register is found in the dma phandle and #dma-cells is set to 2.
> +control register is found in the dma phandle and #dma-cells is set to 2.
>  
>  	dma0: dma-mux@0 {
>  		compatible = "renesas,shdma-mux";
> 

Ok, if I don't fix this in the new series then you have my ack for
this to be applied.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
