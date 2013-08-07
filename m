From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:24:20 +0000
Subject: [GIT PULL 3/4] ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
Message-Id: <ab4d2cd1c9543efdf7e9bf942c0199d199abf3e0.1375842392.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375842392.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375842392.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/ape6evm_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index dab5a7d..e4359c7 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -54,7 +54,8 @@ CONFIG_NETDEVICES=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 # CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_NONSTANDARD=y
-- 
1.8.3.2

