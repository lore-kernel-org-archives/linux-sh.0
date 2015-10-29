From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 29 Oct 2015 21:50:47 +0000
Subject: [PATCH 0/2] sh_eth: fix bugs in sh_eth_ring_init()
Message-Id: <5844359.Wmo6777QiE@wasted.cogentembedded.com>
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
[2/2] sh_eth: fix WARNING in dma_free_coherent()

MBR, Sergei

