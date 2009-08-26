From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:18 +0000
Subject: [PATCH 0/6] EcoVec24 patches
Message-Id: <ueiqyhm4t.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all
These patches are for EcoVec24

      sh: sh: modify to enable boot for EcoVec24
      sh: Add SH-ETH support for EcoVec24
      sh: Add USB support for EcoVec24
      sh: Add support LCDC for EcoVec24
      sh: Add CEU support for EcoVec24
      sh: Add LCDC Panel support for EcoVec24

2nd SH-ETH patch doesn't have .hwblk_id = HWBLK_ETHER.
I will add this id if it start works.

3rd USB patch support USB host only.

I tested 5th CEU patch with my local patch.
I will send this patch to ML

