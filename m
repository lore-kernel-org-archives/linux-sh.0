From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 17 Nov 2010 07:48:19 +0000
Subject: Re: [PATCH 00/05] fbdev: SH-Mobile MIPI-DSI Update
Message-Id: <Pine.LNX.4.64.1011170846410.25275@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20101117064405.18139.57035.sendpatchset@t400s>
In-Reply-To: <20101117064405.18139.57035.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Wed, 17 Nov 2010, Magnus Damm wrote:

> fbdev: SH-Mobile MIPI-DSI Update
> 
> [PATCH 01/05] fbdev: sh_mipi_dsi: Remove request/release mem region
> [PATCH 02/05] fbdev: sh_mipi_dsi: Make use of register names
> [PATCH 03/05] ARM: mach-shmobile: Extend AP4EVB MIPI-DSI resources
> [PATCH 04/05] fbdev: sh_mipi_dsi: Require two I/O resources
> [PATCH 05/05] fbdev: sh_mipi_dsi: Allow LCDC board callbacks

Thanks for the patches, Magnus! Agree with Paul regarding [PATCH 1/5], for 
2-5 here's an

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Regards
Guennadi

> 
> These patches contain a few rather trivial updates for the
> sh_mipi_dsi driver. Necessary changes to the AP4EVB specific
> platform data is also included in [PATCH 03/05]. It should
> be applied before [PATCH 04/05].
> 
> The patches above contain the following two major features:
> - Support newer SoCs with different I/O base adresses
> - Allow board-specific LCDC hooks together with MIPI-DSI
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |    7 +
>  drivers/video/sh_mipi_dsi.c           |  131 ++++++++++++++++++++-------------
>  2 files changed, 87 insertions(+), 51 deletions(-)
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
