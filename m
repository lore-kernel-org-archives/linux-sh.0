From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:28:23 +0000
Subject: [PATCH][rework] ARM: shmobile: patch set rework
Message-Id: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

These are rework patch set which are not included on latest rafael's tree.
(and additional patch)
I separated each patches to become independent as much as possible.

My previous patch set tried to sharing "gpio" and "DMAEngine" definitions on top.
This patch set still try to sharing it, but it was on last patches.

gpio/DMAEngine sharing patch were separated as "add common xxx",
and "use common xxx".
I hope it is good fit for rafael's branch control

1st "PM domain" patch is new one.
It adds very basic PM domain support for Armadillo

Kuninori Morimoto (1):
      ARM: shmobile: r8a7740: basic PM domain support

Kuninori Morimoto (2):
      ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
      ARM: shmobile: armadillo800eva: enable FSI-HDMI sound

Kuninori Morimoto (3):
      ARM: shmobile: sh73a0: add USB clock support
      ARM: shmobile: kzm9g: enable USB func
      ARM: shmobile: kzm9g: enable MicroSD

Kuninori Morimoto (6):
      ARM: shmobile: r8a7740: add DMAEngine support for FSI
      ARM: shmobile: r8a7740: add DMAEngine support for SDHI
      ARM: shmobile: r8a7740: add DMAEngine support for USB
      ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
      ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
      ARM: shmobile: armadillo800eva: enable DMAEngine on USB

Kuninori Morimoto (3):
      ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
      ARM: shmobile: kzm9g: enable DMAEngine on FSI
      ARM: shmobile: kzm9g: enable DMAEngine on MMCIF

Kuninori Morimoto (5):
      ARM: shmobile: add common extra gpio functions
      ARM: shmobile: use common extra gpio functions on ap4evb
      ARM: shmobile: use common extra gpio functions on g4evm
      ARM: shmobile: use common extra gpio functions on mackrel
      ARM: shmobile: use common extra gpio functions on armadillo800eva

Kuninori Morimoto (4):
      ARM: shmobile: add common DMAEngine definitions
      ARM: shmobile: use common DMAEngine definitions on r8a7740
      ARM: shmobile: use common DMAEngine definitions on sh7372
      ARM: shmobile: use common DMAEngine definitions on sh73a0


Best regards
---
Kuninori Morimoto
