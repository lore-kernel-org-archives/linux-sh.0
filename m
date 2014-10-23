From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 23 Oct 2014 03:14:12 +0000
Subject: [PATCH v3 0/1] spi: Using Trigger number to transmit/receive data
Message-Id: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert+renesas@glider.be
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Geert-san,

I have updated a new version of the QSPI patch (verion 3), that I modified as 
your comments. This patch supports for r8a7790 SOC and developed base on the 
upstream-stable-v3.17 and have tested on the Lager board.
Please consider the following patches for the r8a7790 Soc.

Version 2:
Added the DMA support on it.In order to use DMA When the DMA is available. 
This patch supports for r8a7790 SOC and developed base on the upstream-v3.17-rc7
and have tested on the Lager board.

Version 1:

This is the patch of QSPI that support for r8a7790 SOC. The pupose of 
this patch is to transmit and receive the 32 bytes of data when the data 
already has prepared on Transmit/Receive Buffer. Using Transmit/Receive 
Buffer Data Trigger Number to do that instead transmits/receives a byte 
of data. With this patch will improve the speed of transfer data.
This patch was developed base on the upstream-v3.17-rc5 and have 
tested on the Lager board.

Best Regards,
Cao Minh Hiep 

Hiep Cao Minh (1):
  spi: Using Trigger number to transmit/receive data

 drivers/spi/spi-rspi.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 7 deletions(-)

-- 
1.9.1

