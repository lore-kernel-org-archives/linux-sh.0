From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 11 Feb 2008 17:41:49 +0000
Subject: [PATCH/HP6XX] Tidy include/asm-sh/hp6xx.h
Message-Id: <20080211184149.35bc1d3e.Kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Mon__11_Feb_2008_18_41_49_+0100_l6yuEdg_OGACzetr"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Mon__11_Feb_2008_18_41_49_+0100_l6yuEdg_OGACzetr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Greetings,

shortlog:
This patch removes defunct. led support functions from hp6xx.h since they are now 
added in a proper driver (see commit below). Also adds tabs instead of spaces before comments.

*commit d39a7a63eb3971b1b3cc5c181ed526bf437b1c72

signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>


diff --git a/include/asm-sh/hp6xx.h b/include/asm-sh/hp6xx.h
index 53ca564..0d4165a 100644
--- a/include/asm-sh/hp6xx.h
+++ b/include/asm-sh/hp6xx.h
@@ -10,9 +10,9 @@
  *
  */
 
-#define HP680_BTN_IRQ		32            /* IRQ0_IRQ */
-#define HP680_TS_IRQ		35            /* IRQ3_IRQ */
-#define HP680_HD64461_IRQ	36            /* IRQ4_IRQ */
+#define HP680_BTN_IRQ		32	/* IRQ0_IRQ */
+#define HP680_TS_IRQ		35	/* IRQ3_IRQ */
+#define HP680_HD64461_IRQ	36	/* IRQ4_IRQ */
 
 #define DAC_LCD_BRIGHTNESS	0
 #define DAC_SPEAKER_VOLUME	1
@@ -55,26 +55,4 @@
 #define PJDR	0xa4000130
 #define PKDR	0xa4000132
 
-static inline void hp6xx_led_red(int on)
-{
-	u16 v16;
-	v16 = ctrl_inw(CONFIG_HD64461_IOBASE + HD64461_GPBDR - 0x10000);
-	if (on)
-	    ctrl_outw(v16 & (~HD64461_GPBDR_LED_RED), CONFIG_HD64461_IOBASE + HD64461_GPBDR - 0x10000);
-	else
-	    ctrl_outw(v16 | HD64461_GPBDR_LED_RED, CONFIG_HD64461_IOBASE + HD64461_GPBDR - 0x10000);
-}
-
-static inline void hp6xx_led_green(int on)
-{
-	u8 v8;
-
-	v8 = ctrl_inb(PKDR);
-	if (on)
-	    ctrl_outb(v8 & (~PKDR_LED_GREEN), PKDR);
-	else
-	    ctrl_outb(v8 | PKDR_LED_GREEN, PKDR);
-}
-
-
 #endif /* __ASM_SH_HP6XX_H */

--Multipart=_Mon__11_Feb_2008_18_41_49_+0100_l6yuEdg_OGACzetr
Content-Type: application/octet-stream;
 name="hp6xx-tidy-hp6xx.h.patch"
Content-Disposition: attachment;
 filename="hp6xx-tidy-hp6xx.h.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvYXNtLXNoL2hwNnh4LmggYi9pbmNsdWRlL2FzbS1zaC9ocDZ4
eC5oCmluZGV4IDUzY2E1NjQuLjBkNDE2NWEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNtLXNoL2hw
Nnh4LmgKKysrIGIvaW5jbHVkZS9hc20tc2gvaHA2eHguaApAQCAtMTAsOSArMTAsOSBAQAogICoK
ICAqLwogCi0jZGVmaW5lIEhQNjgwX0JUTl9JUlEJCTMyICAgICAgICAgICAgLyogSVJRMF9JUlEg
Ki8KLSNkZWZpbmUgSFA2ODBfVFNfSVJRCQkzNSAgICAgICAgICAgIC8qIElSUTNfSVJRICovCi0j
ZGVmaW5lIEhQNjgwX0hENjQ0NjFfSVJRCTM2ICAgICAgICAgICAgLyogSVJRNF9JUlEgKi8KKyNk
ZWZpbmUgSFA2ODBfQlROX0lSUQkJMzIJLyogSVJRMF9JUlEgKi8KKyNkZWZpbmUgSFA2ODBfVFNf
SVJRCQkzNQkvKiBJUlEzX0lSUSAqLworI2RlZmluZSBIUDY4MF9IRDY0NDYxX0lSUQkzNgkvKiBJ
UlE0X0lSUSAqLwogCiAjZGVmaW5lIERBQ19MQ0RfQlJJR0hUTkVTUwkwCiAjZGVmaW5lIERBQ19T
UEVBS0VSX1ZPTFVNRQkxCkBAIC01NSwyNiArNTUsNCBAQAogI2RlZmluZSBQSkRSCTB4YTQwMDAx
MzAKICNkZWZpbmUgUEtEUgkweGE0MDAwMTMyCiAKLXN0YXRpYyBpbmxpbmUgdm9pZCBocDZ4eF9s
ZWRfcmVkKGludCBvbikKLXsKLQl1MTYgdjE2OwotCXYxNiA9IGN0cmxfaW53KENPTkZJR19IRDY0
NDYxX0lPQkFTRSArIEhENjQ0NjFfR1BCRFIgLSAweDEwMDAwKTsKLQlpZiAob24pCi0JICAgIGN0
cmxfb3V0dyh2MTYgJiAofkhENjQ0NjFfR1BCRFJfTEVEX1JFRCksIENPTkZJR19IRDY0NDYxX0lP
QkFTRSArIEhENjQ0NjFfR1BCRFIgLSAweDEwMDAwKTsKLQllbHNlCi0JICAgIGN0cmxfb3V0dyh2
MTYgfCBIRDY0NDYxX0dQQkRSX0xFRF9SRUQsIENPTkZJR19IRDY0NDYxX0lPQkFTRSArIEhENjQ0
NjFfR1BCRFIgLSAweDEwMDAwKTsKLX0KLQotc3RhdGljIGlubGluZSB2b2lkIGhwNnh4X2xlZF9n
cmVlbihpbnQgb24pCi17Ci0JdTggdjg7Ci0KLQl2OCA9IGN0cmxfaW5iKFBLRFIpOwotCWlmIChv
bikKLQkgICAgY3RybF9vdXRiKHY4ICYgKH5QS0RSX0xFRF9HUkVFTiksIFBLRFIpOwotCWVsc2UK
LQkgICAgY3RybF9vdXRiKHY4IHwgUEtEUl9MRURfR1JFRU4sIFBLRFIpOwotfQotCi0KICNlbmRp
ZiAvKiBfX0FTTV9TSF9IUDZYWF9IICovCg==

--Multipart=_Mon__11_Feb_2008_18_41_49_+0100_l6yuEdg_OGACzetr--
