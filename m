From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 14 Oct 2014 00:57:43 +0000
Subject: [PATCH v2 0/1 resend] spi: Using Trigger number to transmit/receive data
Message-Id: <1413248264-3685-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert+renesas@glider.be
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Geert,

Here is the verion 2 of the QSPI patch, I have added the DMA support on it.
In order to use DMA When the DMA is available. 
This patch supports for r8a7790 SOC and developed base on the upstream-v3.17-rc7
and have tested on the Lager board.
Please review it when you have time!

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

 drivers/spi/spi-rspi.c | 138 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 13 deletions(-)

-- 
1.9.1

