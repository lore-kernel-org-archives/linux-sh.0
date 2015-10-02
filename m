From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 02:56:22 +0000
Subject: [PATCH v10 07/07] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
Message-Id: <20151002025622.28158.98392.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables the Renesas R-Car H3 SoC together with the
SCIF driver in the arm64 defconfig.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
 - None

 Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
 - Added Acked-by from Geert

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - Updated changelog
 - Use CONFIG_RENESAS and CONFIG_R8A7795

 Based on:
  [PATCH 19/25] arm64: defconfig: renesas: Enable Renesas R-Car Gen3 SoC
  [PATCH 20/25] arm64: defconfig: renesas: enable SCIF

 arch/arm64/configs/defconfig |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/arm64/configs/defconfig
+++ work/arch/arm64/configs/defconfig	2015-08-29 17:20:25.712366518 +0900
@@ -39,6 +39,8 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_ARCH_SEATTLE=y
+CONFIG_ARCH_RENESAS=y
+CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_132_SOC=y
 CONFIG_ARCH_QCOM=y
@@ -109,6 +111,9 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
