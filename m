From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Sep 2015 00:29:18 +0000
Subject: Re: [PATCH v2 01/02] irqchip: renesas-irqc: Add r8a7795 INTC-EX DT documentation
Message-Id: <20150929002918.GB17909@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150928094219.32552.18778.sendpatchset@little-apple>
 <20150928094228.32552.83336.sendpatchset@little-apple>
In-Reply-To: <20150928094228.32552.83336.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Mon, Sep 28, 2015 at 06:42:28PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> For some reason the name of the external interrupt controller
> has changed name with r8a7795, so use "intc-ex" instead of "irqc"
> as r8a7795 compat string to follow the friendly documentation.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
>  Changes since V1:
>  - Use "intc-ex" instead of "irqc" to follow the data sheet.
>  - Added ack from Geert.
> 
>  Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 0001/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> +++ work/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt	2015-09-28 18:12:43.250513000 +0900
> @@ -10,6 +10,7 @@ Required properties:
>      - "renesas,irqc-r8a7792" (R-Car V2H)
>      - "renesas,irqc-r8a7793" (R-Car M2-N)
>      - "renesas,irqc-r8a7794" (R-Car E2)
> +    - "renesas,intc-ex-r8a7795" (R-Car H3)
>  - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
>    interrupts.txt in this directory
>  - clocks: Must contain a reference to the functional clock.
> 
