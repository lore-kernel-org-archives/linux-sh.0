From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:07:33 +0000
Subject: [PATCH 16/18 v3] arm64: defconfig: add Renesas sound and AK4613 support
Message-Id: <87pp1gzdp5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index abb8cdd..e333159 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -142,6 +142,11 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_RCAR=y
+CONFIG_SND_SOC_AK4613=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-- 
1.9.1

