From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Jan 2013 15:32:33 +0000
Subject: [PATCH/RFC v2 06/11] mmc: tmio-mmc: define device-tree bindings
Message-Id: <1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Define device-tree bindings for the tmio-mmc driver to be able to specify
parameters, currently provided in platform data.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Please, comment on this one, since it is defining an ABI

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/tmio_mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
new file mode 100644
index 0000000..dd8decd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -0,0 +1,19 @@
+* Toshiba Mobile IO SD/MMC controller
+
+The tmio-mmc driver doesn't probe its devices actively, instead its binding to
+devices is managed by either MFD drivers or by the sh_mobile_sdhi platform
+driver. Those drivers supply the tmio-mmc driver with platform data, that either
+describe hardware capabilities, known to them, or are obtained by them from
+their own platform data or from their DT information. In the latter case all
+compulsory and any optional properties, common to all SD/MMC drivers, as
+described in mmc.txt, should or can be used. Additionally the following optional
+bindings can be used. They set either respective TMIO_MMC_* flags or MMC_CAP_*
+capabilities.
+
+Optional properties:
+- toshiba,mmc-wrprotect-disable	: set TMIO_MMC_WRPROTECT_DISABLE flag
+- toshiba,mmc-blksz-2bytes	: set TMIO_MMC_BLKSZ_2BYTES
+- toshiba,mmc-cap-sdio-irq	: SDIO IRQ signalling should be used, if
+	supported by the hardware, i.e. set MMC_CAP_SDIO_IRQ if
+	TMIO_MMC_SDIO_IRQ is also set
+- toshiba,mmc-has-idle-wait	: set TMIO_MMC_HAS_IDLE_WAIT
-- 
1.7.2.5

