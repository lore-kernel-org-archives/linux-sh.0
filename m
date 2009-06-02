From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 02 Jun 2009 02:49:05 +0000
Subject: [PATCH v2 0/4] add L2 cache support
Message-Id: <ueiu3e4f2.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


These are v2 patches to add support L2 cache

[PATCH 1/4] cache.h: add RAMCR definition for sh4
[PATCH 2/4] sh: add l2_cache_init function on cache_init
[PATCH 3/4] sh7724: add l2_cache_init support
[PATCH 4/4] sh7723: add l2_cache_init support
