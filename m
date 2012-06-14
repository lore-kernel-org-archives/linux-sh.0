From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Jun 2012 04:11:13 +0000
Subject: Re: [PATCH v2] mmc: tmio: Don't access hardware registers after stopping clocks
Message-Id: <87ehpir0rl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


Laurent Pinchart wrote:
> 
> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the mmc core requests the driver to power off the card, we
> inform runtime PM, that the controller can be suspended. This can lead
> to the MSTP clock being turned off.
> 
> Writing to any 16-bit hardware registers with the MSTP clock off leads
> to timeouts and errors being printed to the kernel log. This can occur
> both when stopping the MMC clock and when configuring the bus width.
> 
> To fix this, stop the MMC clock before calling put_runtime_pm(), and
> skip bus width configuration when power is off.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---

This patch solved kzm9g MicroSD hang-up issue.

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
