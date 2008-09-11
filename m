From: Luca Santini <luca.santini@spesonline.com>
Date: Thu, 11 Sep 2008 10:22:37 +0000
Subject: [PATCH] edosk7760 physmap-flash support defconfig
Message-Id: <48C8F16D.5000608@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

diff --git a/arch/sh/configs/edosk7760_defconfig 
b/arch/sh/configs/edosk7760_defconfig
index f8ec32a..bef07fa 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -380,11 +380,11 @@ CONFIG_DEBUG_DEVRES=y
  # CONFIG_CONNECTOR is not set
  CONFIG_MTD=y
  CONFIG_MTD_DEBUG=y
-CONFIG_MTD_DEBUG_VERBOSE=3
+CONFIG_MTD_DEBUG_VERBOSE=0
  CONFIG_MTD_CONCAT=y
  CONFIG_MTD_PARTITIONS=y
  # CONFIG_MTD_REDBOOT_PARTS is not set
-# CONFIG_MTD_CMDLINE_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
  # CONFIG_MTD_AR7_PARTS is not set

  #
@@ -411,16 +411,16 @@ CONFIG_MTD_CFI_NOSWAP=y
  # CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
  # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
  CONFIG_MTD_CFI_GEOMETRY=y
-# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
  CONFIG_MTD_MAP_BANK_WIDTH_2=y
-# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
-# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_MAP_BANK_WIDTH_8=y
+CONFIG_MTD_MAP_BANK_WIDTH_16=y
+CONFIG_MTD_MAP_BANK_WIDTH_32=y
  CONFIG_MTD_CFI_I1=y
-# CONFIG_MTD_CFI_I2 is not set
-# CONFIG_MTD_CFI_I4 is not set
-# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_I4=y
+CONFIG_MTD_CFI_I8=y
  # CONFIG_MTD_OTP is not set
  CONFIG_MTD_CFI_INTELEXT=y
  CONFIG_MTD_CFI_AMDSTD=y
@@ -435,9 +435,9 @@ CONFIG_MTD_ABSENT=y
  #
  # CONFIG_MTD_COMPLEX_MAPPINGS is not set
  CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_START=0xA0000000
-CONFIG_MTD_PHYSMAP_LEN=0x01000000
-CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+CONFIG_MTD_PHYSMAP_START=0xffffffff
+CONFIG_MTD_PHYSMAP_LEN=0x0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=4
  # CONFIG_MTD_PLATRAM is not set

  #

