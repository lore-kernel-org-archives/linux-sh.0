From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 21 May 2009 20:12:58 +0000
Subject: [PATCH] panasonic-laptop: beyond ARRAY_SIZE of pcc->keymap
Message-Id: <4A15B5CA.9060907@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do not go beyond ARRAY_SIZE of pcc->keymap

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
This is against linux-next

diff --git a/drivers/misc/panasonic-laptop.c b/drivers/misc/panasonic-laptop.c
index 4a1bc64..d82d1cc 100644
--- a/drivers/misc/panasonic-laptop.c
+++ b/drivers/misc/panasonic-laptop.c
@@ -515,7 +515,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 
 	hkey_num = result & 0xf;
 
-	if (hkey_num < 0 || hkey_num > ARRAY_SIZE(pcc->keymap)) {
+	if (hkey_num < 0 || hkey_num >= ARRAY_SIZE(pcc->keymap)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "hotkey number out of range: %d\n",
 				  hkey_num));

