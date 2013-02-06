From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 06 Feb 2013 19:46:53 +0000
Subject: [PATCH v3 06/13] mmc: tmio-mmc: define device-tree bindings
Message-Id: <1360180020-18555-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

Define device-tree bindings for the tmio-mmc driver to be able to specify
parameters, currently provided in platform data.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: make the property to set TMIO_MMC_SDIO_IRQ global

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
new file mode 100644
index 0000000..5762a55
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -0,0 +1,15 @@
+* Toshiba Mobile IO SD/MMC controller
+
+The tmio-mmc driver doesn't probe its devices actively, instead its binding to
+devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
+driver. Those drivers supply the tmio-mmc driver with platform data, that either
+describe hardware capabilities, known to them, or are obtained by them from
+their own platform data or from their DT information. In the latter case all
+compulsory and any optional properties, common to all SD/MMC drivers, as
+described in mmc.txt, should or can be used. Additionally the following optional
+bindings can be used. They set respective TMIO_MMC_* flags.
+
+Optional properties:
+- toshiba,mmc-wrprotect-disable	: set TMIO_MMC_WRPROTECT_DISABLE flag
+- toshiba,mmc-blksz-2bytes	: set TMIO_MMC_BLKSZ_2BYTES
+- toshiba,mmc-has-idle-wait	: set TMIO_MMC_HAS_IDLE_WAIT
-- 
1.7.2.5

