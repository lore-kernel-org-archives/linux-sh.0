From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 26 Apr 2012 03:55:11 +0000
Subject: [PATCH 0/2] ARM: mach-shmobile: armadillo/kzm9g defconfig update
Message-Id: <87d36vuoyr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

These are defconfig update patches for Armadillo/kzm9g

Kuninori Morimoto (1):
      ARM: mach-shmobile: armadillo800eva: defconfig update

Kuninori Morimoto (1):
      ARM: mach-shmobile: kzm9g: defconfig update

1/2 patch is for rafael/armadillo800eva branch, and
2/2 patch is for rafael/kzm9g branch

These patches update defconfig to enable new devices on each board,
and reduced unneeded settings.

These defconfig were cleanuped by c2330e286f68f1c408b4aa6515ba49d57f05beae script

Best regards
---
Kuninori Morimoto
