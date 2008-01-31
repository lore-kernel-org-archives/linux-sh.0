From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 31 Jan 2008 21:58:11 +0000
Subject: [PATCH/KCONFIG] - Add SUPERH depends to sound/soc/sh/Kconfig
Message-Id: <20080131225811.a175de2c.Kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Thu__31_Jan_2008_22_58_11_+0100_T.LFLr8sW.nawaOg"
List-Id: <linux-sh.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Thu__31_Jan_2008_22_58_11_+0100_T.LFLr8sW.nawaOg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Currently you will see an empty "SoC Audio support for SuperH" menu 
when building for other archs (example pxa).
This patch adds "depends on SUPERH" to remove that empty menu.

signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index f03220d..4c1e013 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -1,4 +1,5 @@
 menu "SoC Audio support for SuperH"
+	depends on SUPERH
 
 config SND_SOC_PCM_SH7760
 	tristate "SoC Audio support for Renesas SH7760"


--Multipart=_Thu__31_Jan_2008_22_58_11_+0100_T.LFLr8sW.nawaOg
Content-Type: application/octet-stream;
 name="SoC-SuperH-add-depends.patch"
Content-Disposition: attachment;
 filename="SoC-SuperH-add-depends.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zaC9LY29uZmlnIGIvc291bmQvc29jL3NoL0tjb25maWcK
aW5kZXggZjAzMjIwZC4uNGMxZTAxMyAxMDA2NDQKLS0tIGEvc291bmQvc29jL3NoL0tjb25maWcK
KysrIGIvc291bmQvc29jL3NoL0tjb25maWcKQEAgLTEsNCArMSw1IEBACiBtZW51ICJTb0MgQXVk
aW8gc3VwcG9ydCBmb3IgU3VwZXJIIgorCWRlcGVuZHMgb24gU1VQRVJICiAKIGNvbmZpZyBTTkRf
U09DX1BDTV9TSDc3NjAKIAl0cmlzdGF0ZSAiU29DIEF1ZGlvIHN1cHBvcnQgZm9yIFJlbmVzYXMg
U0g3NzYwIgo=

--Multipart=_Thu__31_Jan_2008_22_58_11_+0100_T.LFLr8sW.nawaOg--
