From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Tue, 08 Jan 2019 09:16:15 +0000
Subject: Re: [PATCH RFT v2] net: sh_eth: add support for SH7786
Message-Id: <20190108101615.165c5a4b@windsurf>
List-Id: <linux-sh.vger.kernel.org>
References: <cbc7976d-2376-15d4-0fc1-febdf142887b@cogentembedded.com>
In-Reply-To: <cbc7976d-2376-15d4-0fc1-febdf142887b@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello Sergei,

Thanks for your work on this topic!

On Fri, 4 Jan 2019 15:53:24 +0300, Sergei Shtylyov wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> This commit adds the sh_eth_cpu_data structure that describes the
> SH7786 variant of the IP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

I tried to test this patch today, and it doesn't work for the moment.
However, I've rebased my whole SH7786 patch stack on top of 4.20, and
with my original sh_eth patch, network is also not working, so I can't
say whether it's really this patch that has an issue, or some other
aspects.

(And yes, I remember to adjust the base address of the sh_eth
platform_device:

diff --git a/arch/sh/boards/board-wdc-cont4.c b/arch/sh/boards/board-wdc-cont4.c
index c72209822899..7ca1bfcc20ae 100644
--- a/arch/sh/boards/board-wdc-cont4.c
+++ b/arch/sh/boards/board-wdc-cont4.c
@@ -80,7 +80,7 @@ static int wdc_cont4_clk_init(void)
 
 static struct resource sh_eth_resources[] = {
         {
-                .start  = 0xFEE00200,
+                .start  = 0xFEE00000,
                 .end    = 0xFEE00400 - 1,
                 .flags  = IORESOURCE_MEM,
         }, {

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
