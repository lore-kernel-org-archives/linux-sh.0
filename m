From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 09 Apr 2009 06:09:03 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <49DD90FF.3030906@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Kuninori Morimoto wrote:
> Timeout counter "i" can reach -1 if USB setup isn't done.
> And "i" can be 0 if USB setup is done when last possible moment.
> Then it is judged to fail though setup is done.
> This patch modify this problem.
> Special thanks to Mr. Juha Leppanen for nice advice.
> 
> Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>> Paul
> Can you test this patch on Urquell board please ?
> 
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> index 5a47e1c..ee30e68 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> @@ -127,6 +127,7 @@ void __init sh7786_usb_use_exclock(void)
>  static void __init sh7786_usb_setup(void)
>  {
>  	int i = 1000000;
> +	u32 val;
>  
>  	/*
>  	 * USB initial settings
> @@ -143,11 +144,14 @@ static void __init sh7786_usb_setup(void)
>  	 * Set the PHY and PLL enable bit
>  	 */
>  	__raw_writel(PHY_ENB | PLL_ENB, USBPCTL1);
> -	while (i-- &&
> -	       ((__raw_readl(USBST) & ACT_PLL_STATUS) != ACT_PLL_STATUS))
> +	while (i--) {
> +		val = __raw_readl(USBST) & ACT_PLL_STATUS;
> +		if (ACT_PLL_STATUS = val)
> +			break;
>  		cpu_relax();
> +	}
>  
> -	if (i) {
> +	if (ACT_PLL_STATUS = val) {
>  		/* Set the PHY RST bit */
>  		__raw_writel(PHY_ENB | PLL_ENB | PHY_RST, USBPCTL1);
>  		printk(KERN_INFO "sh7786 usb setup done\n");

I think this line to be able to be in while.

Best regards,
  Nobuhiro

-----
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 5a47e1c..08dcec5 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -127,6 +127,7 @@ void __init sh7786_usb_use_exclock(void)
  static void __init sh7786_usb_setup(void)
  {
  	int i = 1000000;
+	u32 val;

  	/*
  	 * USB initial settings
@@ -143,14 +144,15 @@ static void __init sh7786_usb_setup(void)
  	 * Set the PHY and PLL enable bit
  	 */
  	__raw_writel(PHY_ENB | PLL_ENB, USBPCTL1);
-	while (i-- &&
-	       ((__raw_readl(USBST) & ACT_PLL_STATUS) != ACT_PLL_STATUS))
+	while (i--) {
+		val = __raw_readl(USBST) & ACT_PLL_STATUS;
+		if (ACT_PLL_STATUS = val) {
+			/* Set the PHY RST bit */
+			__raw_writel(PHY_ENB | PLL_ENB | PHY_RST, USBPCTL1);
+			printk(KERN_INFO "sh7786 usb setup done\n");
+			break;
+		}
  		cpu_relax();
-
-	if (i) {
-		/* Set the PHY RST bit */
-		__raw_writel(PHY_ENB | PLL_ENB | PHY_RST, USBPCTL1);
-		printk(KERN_INFO "sh7786 usb setup done\n");
  	}
  }
