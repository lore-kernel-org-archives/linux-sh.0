From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:38:48 +0000
Subject: [PATCH 0/3] ARM: shmobile: enable DMAEngine on kzm9g
Message-Id: <87sjdjk763.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael, Magnus
Cc Simon

These patch-set enable FSI/MMCIF DMAEngine on kzm9g board

Kuninori Morimoto (3):
      ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
      ARM: shmobile: kzm9g: enable DMAEngine on FSI
      ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
