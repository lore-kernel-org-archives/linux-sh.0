From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 10:39:34 +0000
Subject: [PATCH v2 0/2] [media] rcar_vin: Remove obsolete platform data support
Message-Id: <1444214376-26931-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

Since commit 3d7608e4c169af03 ("ARM: shmobile: bockw: remove legacy
board file and config"), Renesas R-Car SoCs are only supported in
generic DT-only ARM multi-platform builds.  The driver doesn't need to
use platform data anymore, hence this series remove platform data
configuration.

Changes compared to v1:
  - Added patch 2.

Geert Uytterhoeven (2):
  [media] rcar_vin: Remove obsolete r8a779x-vin platform_device_id
    entries
  [media] rcar_vin: Remove obsolete platform data support

 drivers/media/platform/soc_camera/rcar_vin.c | 77 +++++++++++-----------------
 include/linux/platform_data/camera-rcar.h    | 25 ---------
 2 files changed, 29 insertions(+), 73 deletions(-)
 delete mode 100644 include/linux/platform_data/camera-rcar.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
