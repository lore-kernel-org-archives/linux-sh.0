From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 03:49:59 +0000
Subject: [PATCH 0/27] ARM: shmobile: resend patch set
Message-Id: <87mx4aqzhd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael
Cc Magnus, Simon

These are resend/rebase version of my patch set (which are not applied yet)
It includes below patch set
	[PATCH 0/11] ARM: mach-shmobile: armadillo: add FSI/HDMI/Camera support
	[PATCH 0/2]  ARM: mach-shmobile: kzm9g: add FSI support
	[PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
	[PATCH][RFC] ARM: mach-shmobile: sh73a0: bugfix: SY-DMAC number
	[PATCH 0/9]  ARM: mach-shmobile: r8a7740: add DMAEngine support
	[PATCH 0/2]  ARM: mach-shmobile: kzm9g: add FSI DMAEngine support

The diff are...
	- all-in-one patch set
	- I added what/why on log area as much as possible
	- Subject : mach-shmobile -> shmobile 
	- Subject : "add xxx support" -> "enable xxxx" on platform patch
        - based on latest linus/master branch

Some of these patches have "WARNING: line over 80 characters" from checkpatch.pl
on setup/clock/pfc files.
But these are bacause traditional(?) its style.

#1, #2 are bugfix patches.

Kuninori Morimoto (27):
      ARM: shmobile: sh73a0: bugfix: SY-DMAC number
      ARM: shmobile: sh7372: bugfix: chclr_offset base
      ARM: shmobile: shareing extra gpio setting functions
      ARM: shmobile: shareing DMAEngine definitions
      ARM: shmobile: shareing DMAEngine TS_HI/LOW value
      ARM: shmobile: shareing DMAEngine USBTS_HI/LOW value
      ARM: shmobile: r8a7740: add HDMI interrupt support
      ARM: shmobile: r8a7740: add HDMI clock support
      ARM: shmobile: r8a7740: add HDMI GPIO support
      ARM: shmobile: r8a7740: add MERAM work-around
      ARM: shmobile: r8a7740: add CEU clock support
      ARM: shmobile: r8a7740: add FSI parent clock support
      ARM: shmobile: r8a7740: add FSI-B (for HDMI) GPIO support
      ARM: shmobile: r8a7740: add DMAEngine support for FSI
      ARM: shmobile: r8a7740: add DMAEngine support for SDHI
      ARM: shmobile: r8a7740: add DMAEngine support for USB
      ARM: shmobile: armadillo800eva: enable HDMI
      ARM: shmobile: armadillo800eva: enable camera
      ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
      ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
      ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
      ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
      ARM: shmobile: armadillo800eva: enable DMAEngine on USB
      ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
      ARM: shmobile: sh73a0: add FSI clock
      ARM: shmobile: kzm9g: enable FSI-AK4648
      ARM: shmobile: kzm9g: enable DMAEngine on FSI

Best regards
---
Kuninori Morimoto
