From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 30 Sep 2014 04:07:15 +0000
Subject: [PATCH 0/1] spi: Using Trigger number to transmit/receive data
Message-Id: <1412050036-7257-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi Geert,

This is the patch of QSPI that support for r8a7790 SOC. The pupose of 
this patch is to transmit and receive the 32 bytes of data when the data 
already has prepared on Transmit/Receive Buffer. Using Transmit/Receive 
Buffer Data Trigger Number to do that instead transmits/receives a byte 
of data. With this patch will improve the speed of transfer data.

These patches was developed base on the upstream-v3.17-rc5 and have 
tested on the Lager board.

Thank you!

Cao Minh Hiep

Hiep Cao Minh (1):
  spi: Using Trigger number to transmit/receive data

 drivers/spi/spi-rspi.c | 110 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 9 deletions(-)

-- 
1.9.1

