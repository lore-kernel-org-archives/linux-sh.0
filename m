From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 10 Jan 2016 21:26:07 +0000
Subject: [PATCH 0/2] Fix some dubious code in the Renesas Ethernet drivers
Message-Id: <5859243.yu8qorLmay@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's a set of 2 patches against DaveM's 'net.git' repo. While initializing
EMAC the code tries to respect the duplex mode both programmed into ECMR and
stored in its own private data -- this just can't be right.

[1/2] ravb: stop reading ECMR in ravb_emac_init()
[2/2] sh_eth: stop reading ECMR in sh_eth_dev_init()

MBR, Sergei

