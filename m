From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 14:28:12 +0000
Subject: [PATCH] sh: LCDC SYS bus access wait fix
Message-Id: <20090806142812.3947.24083.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the SuperH Mobile LCDC driver to wait for SYS bus to
become idle after reading or writing. This is needed by the
kfr2r09 board, but also fixes potential problems on other
boards making use of the LCDC in a SYS configuration.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on Migo-R and kfr2r09.

 drivers/video/sh_mobile_lcdcfb.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-08-06 21:34:30.000000000 +0900
@@ -154,6 +154,7 @@ static void lcdc_sys_write_index(void *h
 	lcdc_write(ch->lcdc, _LDDWD0R, data | 0x10000000);
 	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 	lcdc_write(ch->lcdc, _LDDWAR, 1 | (lcdc_chan_is_sublcd(ch) ? 2 : 0));
+	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 }
 
 static void lcdc_sys_write_data(void *handle, unsigned long data)
@@ -163,6 +164,7 @@ static void lcdc_sys_write_data(void *ha
 	lcdc_write(ch->lcdc, _LDDWD0R, data | 0x11000000);
 	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 	lcdc_write(ch->lcdc, _LDDWAR, 1 | (lcdc_chan_is_sublcd(ch) ? 2 : 0));
+	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 }
 
 static unsigned long lcdc_sys_read_data(void *handle)
@@ -173,6 +175,7 @@ static unsigned long lcdc_sys_read_data(
 	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 	lcdc_write(ch->lcdc, _LDDRAR, 1 | (lcdc_chan_is_sublcd(ch) ? 2 : 0));
 	udelay(1);
+	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 
 	return lcdc_read(ch->lcdc, _LDDRDR) & 0xffff;
 }
