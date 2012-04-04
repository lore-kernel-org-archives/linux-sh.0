From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Apr 2012 03:10:30 +0000
Subject: Re: [PATCH] sh: fix clock-sh7757 for the latest sh_mobile_sdhi driver
Message-Id: <20120404031030.GC23761@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7BB847.6010801@renesas.com>
In-Reply-To: <4F7BB847.6010801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 04, 2012 at 11:56:07AM +0900, Shimoda, Yoshihiro wrote:
> The commit 996bc8aebd2cd5b6d4c5d85085f171fa2447f364 (mmc: sh_mobile_sdhi:
> do not manage PM clocks manually) modified the sh_mobile_sdhi driver to
> remove the clk_enable/clk_disable. So, we need to change
> the "CLKDEV_CON_ID" to "CLKDEV_DEV_ID".
> 
> If we don't change this, we will see the following error from the driver:
>     sh_mobile_sdhi sh_mobile_sdhi.0: timeout waiting for hardware interrupt (CMD52)
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied, thanks.
