From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 02:53:04 +0000
Subject: [PATCH v2 11/12] sh: add defconfig for J-Core J2
Message-Id: <2f8d611513547a69e42048e35f6cc4b46440c6a4.1463708766.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
In-Reply-To: <cover.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

This defconfig is intended not to be specific to a particular board;
it enables drivers for all currently-supported hardware, and should be
updated to include additional drivers as they are added.

Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/configs/j2_defconfig | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 arch/sh/configs/j2_defconfig

diff --git a/arch/sh/configs/j2_defconfig b/arch/sh/configs/j2_defconfig
new file mode 100644
index 0000000..fca167f
--- /dev/null
+++ b/arch/sh/configs/j2_defconfig
@@ -0,0 +1,38 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CPU_SUBTYPE_J2=y
+CONFIG_MEMORY_START=0x10000000
+CONFIG_MEMORY_SIZE=0x04000000
+CONFIG_CPU_BIG_ENDIAN=y
+CONFIG_SH_DEVICE_TREE=y
+CONFIG_HZ_100=y
+CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_CMDLINE="console=ttyUL0 earlycon"
+CONFIG_BINFMT_ELF_FDPIC=y
+CONFIG_BINFMT_FLAT=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_NETDEVICES=y
+CONFIG_SERIAL_UARTLITE=y
+CONFIG_SERIAL_UARTLITE_CONSOLE=y
+CONFIG_I2C=y
+CONFIG_SPI=y
+CONFIG_SPI_JCORE=y
+CONFIG_WATCHDOG=y
+CONFIG_MMC=y
+CONFIG_MMC_SPI=y
+CONFIG_CLKSRC_JCORE_PIT=y
+CONFIG_JCORE_AIC=y
+CONFIG_EXT4_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
+CONFIG_FAT_DEFAULT_UTF8=y
+CONFIG_NLS_DEFAULT="utf8"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_UTF8=y
-- 
2.8.1


