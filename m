From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Nov 2010 08:05:36 +0000
Subject: Re: [PATCH 00/05] fbdev: SH-Mobile MIPI-DSI Update
Message-Id: <20101119080536.GC28165@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101117064405.18139.57035.sendpatchset@t400s>
In-Reply-To: <20101117064405.18139.57035.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, g.liakhovetski@gmx.de, linux-sh@vger.kernel.org

On Wed, Nov 17, 2010 at 03:44:05PM +0900, Magnus Damm wrote:
> fbdev: SH-Mobile MIPI-DSI Update
> 
> [PATCH 01/05] fbdev: sh_mipi_dsi: Remove request/release mem region
> [PATCH 02/05] fbdev: sh_mipi_dsi: Make use of register names
> [PATCH 03/05] ARM: mach-shmobile: Extend AP4EVB MIPI-DSI resources
> [PATCH 04/05] fbdev: sh_mipi_dsi: Require two I/O resources
> [PATCH 05/05] fbdev: sh_mipi_dsi: Allow LCDC board callbacks
> 
Ok, I've applied the updated version of this with 01/05 dropped and 04/05
replaced with the V2 version. In the future make sure to Cc the
linux-fbdev list, too.
