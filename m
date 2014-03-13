From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 13 Mar 2014 08:29:23 +0000
Subject: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, kuninori.morimoto.gx@renesas.com, geert+renesas@linux-m68k.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

Hi,

This is the patch of QSPI that support for r8a7790 SOC. The pupose of 
this patch is to transmit and receive the 32 bytes of data when the data 
already has prepared on Transmit/Receive Buffer. Using Transmit/Receive 
Buffer Data Trigger Number to do that instead transmits/receives a byte 
of data. With this patch will improve the speed of transfer data.

These patches was developed base on the upstream-v3.14-rc5 and have 
tested on the Lager board.
Please consider the following patches for the r8a7790 Soc.

Thank you!

Cao Minh Hiep


Hiep Cao Minh (1):
  spi: Using Trigger number to transmit/receive data

 drivers/spi/spi-rspi.c |  144 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 20 deletions(-)

-- 
1.7.9.5

