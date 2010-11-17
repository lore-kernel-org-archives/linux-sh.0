From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Nov 2010 06:44:05 +0000
Subject: [PATCH 00/05] fbdev: SH-Mobile MIPI-DSI Update
Message-Id: <20101117064405.18139.57035.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, g.liakhovetski@gmx.de, linux-sh@vger.kernel.org

fbdev: SH-Mobile MIPI-DSI Update

[PATCH 01/05] fbdev: sh_mipi_dsi: Remove request/release mem region
[PATCH 02/05] fbdev: sh_mipi_dsi: Make use of register names
[PATCH 03/05] ARM: mach-shmobile: Extend AP4EVB MIPI-DSI resources
[PATCH 04/05] fbdev: sh_mipi_dsi: Require two I/O resources
[PATCH 05/05] fbdev: sh_mipi_dsi: Allow LCDC board callbacks

These patches contain a few rather trivial updates for the
sh_mipi_dsi driver. Necessary changes to the AP4EVB specific
platform data is also included in [PATCH 03/05]. It should
be applied before [PATCH 04/05].

The patches above contain the following two major features:
- Support newer SoCs with different I/O base adresses
- Allow board-specific LCDC hooks together with MIPI-DSI

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c |    7 +
 drivers/video/sh_mipi_dsi.c           |  131 ++++++++++++++++++++-------------
 2 files changed, 87 insertions(+), 51 deletions(-)
