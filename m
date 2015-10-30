From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 Oct 2015 23:05:19 +0000
Subject: [PATCH v2 0/2] sh_eth: fix bugs in sh_eth_ring_init()
Message-Id: <3291270.dPgp9opalf@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hello.

   Here's a set of 2 patches against DaveM's 'net.git' repo which fix couple of
bugs in the sh_eth_ring_init() function.

[1/2] sh_eth: fix uninitialized arrays in sh_eth_ring_init()
[2/2] sh_eth: fix WARNING in dma_common_free_remap()

MBR, Sergei

