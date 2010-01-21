From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Thu, 21 Jan 2010 09:26:27 +0000
Subject: [PATCH] spi_sh_msiof: Fixed data sampling on the correct edge
Message-Id: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

it seems to me that the spi_sh_msiof.c driver configures REDG and TEDG wrongly. TEDG=0 outputs data at the **rising edge** of the clock and REDG=0 samples data at the **falling edge** of the clock. Therefore for SPI, TEDG must be equal to REDG, otherwise the last byte received is not sampled in the SPI mode 3

The SH7723 HW Reference Manual explains the setting in Figure 20.20 and Figure 20.21 ("SPI Clock and data timing")

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index 51e5e1d..a9fec2f 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -173,13 +173,11 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
        int edge;

        /*
-        * CPOL CPHA     TSCKIZ RSCKIZ TEDG REDG(!)
-        *    0    0         10     10    1    0
-        *    0    1         10     10    0    1
-        *    1    0         11     11    0    1
-        *    1    1         11     11    1    0
-        *
-        * (!) Note: REDG is inverted recommended data sheet setting
+        * CPOL CPHA     TSCKIZ RSCKIZ TEDG REDG
+        *    0    0         10     10    1    1
+        *    0    1         10     10    0    0
+        *    1    0         11     11    0    0
+        *    1    1         11     11    1    1
         */

        sh_msiof_write(p, FCTR, 0);
@@ -193,7 +191,7 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
        edge = cpol ? cpha : !cpha;

        tmp |= edge << 27; /* TEDG */
-       tmp |= !edge << 26; /* REDG */
+       tmp |= edge << 26; /* REDG */
        tmp |= (tx_hi_z ? 2 : 0) << 22; /* TXDIZ */
        sh_msiof_write(p, CTR, tmp);
 }
@@ -280,6 +278,9 @@ static void sh_msiof_spi_read_fifo_8(struct sh_msiof_spi_priv *p,

        for (k = 0; k < words; k++)
                buf_8[k] = sh_msiof_read(p, RFDR) >> fs;
+
+       for (k = 0; k < words; k++)
+               pr_err(" %02x\n", buf_8[k]);
 }

 static void sh_msiof_spi_read_fifo_16(struct sh_msiof_spi_priv *p,

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
