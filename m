From: kuninori.morimoto.gx@renesas.com
Date: Thu, 07 Jul 2011 01:35:38 +0000
Subject: ARM: mach-shmobile: sh7372: A3MP domain support
Message-Id: <87fwmidg9k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus, Rafael

These are A4MP power domain support for SH7372

Kuninori Morimoto (2):
      ARM: mach-shmobile: sh7372: make sure that fsi is peripheral of spu2
      ARM: mach-shmobile: sh7372 A3MP support

Kuninori Morimoto :
      spu-test-20110706.c



I tested it by FSI + spu-test command.

spu-test will show you below message if first power for A4MP
you can watch it by spu-test only

  # ./spu-test
  detected SPU2DSP0 as 1
  # ./spu-test
  detected SPU2DSP0 as 1

spu-test will show you below message if A4MP is already powerd
you can watch it by fsi + spu-test

  # aplay xxx.wav &
  # ./spu-test
  detected SPU2DSP0 as 1
  # ./spu-test
  detected SPU2DSP0 as 0
  SPU2DSP0 state kept since last open

These patches are based on "suspend/pm-domains" branch.

But ALSA (which is framework of FSI) is not good on this branch.
  1) it needs bugfix patch
  2) FSI needs more advanced pm support

	- apply bugfix patch for ALSA
           merge git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git : fix/asocy branch
           or cherry-pick 873bd4cb4fbba6a3e99f750e17ef2ba6ef96e9d3 from it
           (or http://article.gmane.org/gmane.linux.alsa.devel/86874)

	- needs advanced pm support to FSI
	   merge git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git : for-3.1 branch

	/* if your board is mackerel */
        - apply buffix patch for ak4642
           http://article.gmane.org/gmane.linux.alsa.devel/86952


Best regards
---
Kuninori Morimoto
