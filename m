From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Feb 2018 13:50:38 +0000
Subject: Re: [PATCH] arch/sh: fix Ethernet clock for SH7786
Message-Id: <20180226145038.5b6a016f@windsurf.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Mon,  4 Dec 2017 15:30:49 +0100, Thomas Petazzoni wrote:
> The sh_eth driver (used for the Ethernet controller on SH7786) uses
> devm_clk_get(&pdev->dev, NULL) to get its clock. It means that con_id
> = NULL, and therefore a clock lookup made on the con_id doesn't work.
> 
> In order to make sure that the sh_eth driver is able to find its clock
> on SH7786, we switch from using a con_id to a dev_id in the clock
> lookup table for this SoC.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Here as well: patch sent almost 3 months ago, it has a Reviewed-by from
Geert.

Is it possible to apply this patch ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
