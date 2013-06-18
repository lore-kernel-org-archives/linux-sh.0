From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Jun 2013 16:55:27 +0000
Subject: Re: [PATCH v3] DMA: shdma: add DT support
Message-Id: <201306181855.27325.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306181813380.30844@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306181813380.30844@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Simon Horman <horms@verge.net.au>

On Tuesday 18 June 2013, Guennadi Liakhovetski wrote:
> This patch adds Device Tree support to the shdma driver. No special DT
> properties are used, only standard DMA DT bindings are implemented. Since
> shdma controllers reside on SoCs, their configuration is SoC-specific and
> shall be passed to the driver from the SoC platform data, using the
> auxdata procedure.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
