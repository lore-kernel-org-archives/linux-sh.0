From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Feb 2014 08:51:18 +0000
Subject: [PATCH] mtd: m25p80: add support for the Spansion s25fl008k chip
Message-Id: <1392108678-29099-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87ip2jwg4z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ip2jwg4z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mtd@lists.infradead.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
"s25fl008k" is in active use since v3.11-rc1

 drivers/mtd/devices/m25p80.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index b5d4b1ee01ee..db8575cf5408 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -972,6 +972,7 @@ static const struct spi_device_id m25p_ids[] = {
 	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32, 0) },
 	{ "s25sl032a",  INFO(0x010215,      0,  64 * 1024,  64, 0) },
 	{ "s25sl064a",  INFO(0x010216,      0,  64 * 1024, 128, 0) },
+	{ "s25fl008k",  INFO(0xef4014,      0,  64 * 1024,  16, SECT_4K) },
 	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32, SECT_4K) },
 	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
 
-- 
1.7.9.5

