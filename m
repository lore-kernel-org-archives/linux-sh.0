From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:48:18 +0000
Subject: [PATCH v5 5/5] arm64: defconfig: enable EthernetAVB
Message-Id: <1444891698-8780-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is present on the Renesas r8a7795 SoC and may be
used by the Salvator-X board.

Also enable MICREL_PHY which is used on the Salvator-X board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v2
* Enable MICREL_PHY

v3
* Added Ack

v4, v5
* No change
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dccc685b58ae..79a09de4f52f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -97,8 +97,10 @@ CONFIG_TUN=y
 CONFIG_VIRTIO_NET=y
 CONFIG_NET_XGENE=y
 CONFIG_SKY2=y
+CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
+CONFIG_MICREL_PHY=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
-- 
2.1.4

