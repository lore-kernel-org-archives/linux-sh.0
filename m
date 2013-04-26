From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 26 Apr 2013 16:02:00 +0000
Subject: Re: [PATCH 0/3] mmc: sdhi / tmio: add DT DMA
Message-Id: <20130426160200.GE4796@zurbaran>
List-Id: <linux-sh.vger.kernel.org>
References: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1366991239-22602-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Guennadi,

On Fri, Apr 26, 2013 at 05:47:16PM +0200, Guennadi Liakhovetski wrote:
> These 3 patches add Device Tree DMA support to the TMIO MMC driver, when 
> used on SDHI platforms.
> 
> Samuel: these patches touch an mfd header file lightly, I think, it's 
> better just to get your ack than to make a separate patch via your tree.
Yes, that is fine with me.

For the mfd/tmio.h part:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
