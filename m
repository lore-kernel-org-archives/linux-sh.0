From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 07 Oct 2013 04:23:48 +0000
Subject: [PATCH 0/2] ARM: shmobile: lager: add MMCIF support on DT
Message-Id: <87fvsdbtf3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add MMCIF support on Lager board with DT.
I tested these patches on Initramfs environment
since current Lager DT doesn't support sh_eth on DT.

These are based on renesas-devel-20131004 tag

Kuninori Morimoto (2):
      ARM: shmobile: lager: add default PFC settings on DTS
      ARM: shmobile: lager: add MMCIF support on DTS

 arch/arm/boot/dts/r8a7790-lager-reference.dts |   39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)


Best regards
---
Kuninori Morimoto
