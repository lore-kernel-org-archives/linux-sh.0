From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 27 Oct 2015 23:05:29 +0000
Subject: [PATCH v4 3/3] arm64: defconfig: Enable Renesas R-Car I2C Controller
Message-Id: <1445987129-13496-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1445987129-13496-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dccc685b58ae..618f156fb90b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -121,6 +121,8 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_PINCTRL_MSM8916=y
-- 
2.1.4

