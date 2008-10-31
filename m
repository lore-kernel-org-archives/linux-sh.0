From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 31 Oct 2008 07:01:19 +0000
Subject: [PATCH] NFS boot panic fix on Migo-r
Message-Id: <ur65x8c89.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


NFS boot is very important for developer,
but kernel panic occur when I use migor_defconfig.
Because there is no setting for it.
This patch fix this problem.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/configs/migor_defconfig |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 624c47a..30cac42 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.27
-# Tue Oct 21 12:57:28 2008
+# Linux kernel version: 2.6.28-rc2
+# Fri Oct 31 15:58:06 2008
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -73,7 +73,6 @@ CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_AIO=y
 CONFIG_VM_EVENT_COUNTERS=y
-CONFIG_PCI_QUIRKS=y
 CONFIG_SLAB=y
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
@@ -285,7 +284,7 @@ CONFIG_GUSA=y
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ip=on"
+CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=serial ip=on root=/dev/nfs ip=dhcp"
 
 #
 # Bus options
@@ -718,6 +717,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
 
@@ -969,7 +969,23 @@ CONFIG_TMPFS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_REGISTER_V4 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
 
 #
 # Partition Types
@@ -1019,7 +1035,12 @@ CONFIG_CRYPTO=y
 # Crypto core or helper
 #
 # CONFIG_CRYPTO_FIPS is not set
-# CONFIG_CRYPTO_MANAGER is not set
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_CRYPTD is not set
@@ -1096,7 +1117,7 @@ CONFIG_CRYPTO=y
 # Random Number Generation
 #
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_HW is not set
 
 #
 # Library routines
-- 
1.5.4.3

