From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 27 May 2013 01:02:32 +0000
Subject: [PATCH] mtd: m25p80: add support for the Spansion s25fl008k chip
Message-Id: <87ip258cbe.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
 <87d2si4cdn.wl%kuninori.morimoto.gx@renesas.com>
 <87a9nm4cax.wl%kuninori.morimoto.gx@renesas.com>
 <20130525014925.GB28458@verge.net.au>
In-Reply-To: <20130525014925.GB28458@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Cc: Magnus <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>


Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> This is repost patch

 drivers/mtd/devices/m25p80.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 2f3d2a5..1bad33a 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -780,6 +780,7 @@ static const struct spi_device_id m25p_ids[] = {
 	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32, 0) },
 	{ "s25sl032a",  INFO(0x010215,      0,  64 * 1024,  64, 0) },
 	{ "s25sl064a",  INFO(0x010216,      0,  64 * 1024, 128, 0) },
+	{ "s25fl008k",  INFO(0xef4014,      0,  64 * 1024,  16, SECT_4K) },
 	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32, SECT_4K) },
 	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
 
-- 
1.7.9.5

