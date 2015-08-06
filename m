From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 06 Aug 2015 08:43:09 +0000
Subject: RE: [PATCH 05/13 v4][RFC] arm64: renesas: Add SCIF2 support on r8a7795
Message-Id: <SG2PR06MB0919196CE3165263B6292FE2D8740@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pp30yhby.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,


> Sent: Thursday, August 06, 2015 5:07 PM
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch enables SCIF2
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
< snip >
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index e84b13a..8c97599 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -23,6 +23,10 @@ Required properties:
< snip >
> +    - "renesas,scifa-r8a7795" for R8A7795 (R-Car H3) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7795" for R8A7795 (R-Car H3) SCIFB compatible UART.

The R8A7795 doesn't have SCIFA and SCIFB.
(In other words, it has SCIF and HSCIF.)

Best regards,
Yoshihiro Shimoda

