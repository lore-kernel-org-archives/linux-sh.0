From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Fri, 26 Jun 2020 13:15:24 +0000
Subject: [PATCH] arch/sh/configs: remove obsolete CONFIG_SOC_CAMERA*
Message-Id: <8d39ddaf-8779-3bc2-6344-a914f583ffb5@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <20200626115321.1898798-1-hverkuil-cisco@xs4all.nl>
 <20200626115321.1898798-8-hverkuil-cisco@xs4all.nl>
In-Reply-To: <20200626115321.1898798-8-hverkuil-cisco@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Drop all configs with the CONFIG_SOC_CAMERA prefix since those
have been removed.

SOC_CAMERA support for the sh architecture was removed a long time ago.
Drop it from the configs.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 arch/sh/configs/ap325rxa_defconfig | 3 ---
 arch/sh/configs/ecovec24_defconfig | 3 ---
 arch/sh/configs/migor_defconfig    | 3 ---
 arch/sh/configs/se7724_defconfig   | 2 --
 4 files changed, 11 deletions(-)

diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index cc6e4ce53dac..5193b3e099b9 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -65,9 +65,6 @@ CONFIG_VIDEO_DEV=y
 # CONFIG_VIDEO_ALLOW_V4L1 is not set
 # CONFIG_MEDIA_TUNER_CUSTOMISE is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_SOC_CAMERA=y
-CONFIG_SOC_CAMERA_PLATFORM=y
-CONFIG_SOC_CAMERA_OV772X=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index 2fb7db4957ce..03cb916819fa 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -72,9 +72,6 @@ CONFIG_MEDIA_SUPPORT=y
 CONFIG_VIDEO_DEV=y
 # CONFIG_MEDIA_TUNER_CUSTOMISE is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_SOC_CAMERA=y
-CONFIG_SOC_CAMERA_MT9T112=y
-CONFIG_SOC_CAMERA_TW9910=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_V4L_USB_DRIVERS is not set
 CONFIG_FB=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 494a1675c226..37e9521a99e5 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -62,9 +62,6 @@ CONFIG_VIDEO_DEV=y
 # CONFIG_VIDEO_ALLOW_V4L1 is not set
 # CONFIG_MEDIA_TUNER_CUSTOMISE is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_SOC_CAMERA=y
-CONFIG_SOC_CAMERA_TW9910=y
-CONFIG_SOC_CAMERA_OV772X=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index 0e8d5cc1e107..a26f7f1841c7 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -70,8 +70,6 @@ CONFIG_VIDEO_DEV=y
 CONFIG_DVB_CORE=m
 # CONFIG_MEDIA_TUNER_CUSTOMISE is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
-CONFIG_SOC_CAMERA=y
-CONFIG_SOC_CAMERA_OV772X=y
 CONFIG_VIDEO_SH_MOBILE_CEU=y
 # CONFIG_RADIO_ADAPTERS is not set
 # CONFIG_DVB_FE_CUSTOMISE is not set
-- 
2.27.0
