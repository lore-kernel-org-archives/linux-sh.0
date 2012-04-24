From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:19:46 +0000
Subject: [PATCH 0/2][for LTSI] ARM: mach-shmobile: armadillo800eva: add FSI support
Message-Id: <87wr55ebbl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871unf9bi7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871unf9bi7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

These are FSI support patch for armadillo800eva,
but it needs ASoC branch merge.

I will re-post these patches after merge,
but post now for Simon's LTSI backport work.

Kuninori Morimoto (2):
      ARM: mach-shmobile: clock-r8a7740: add FSI clock
      ARM: mach-shmobile: armadillo800eva: Add FSI-WM8978 support

Below patches are required for FSI support.
you can find from
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

f2390880ec0264a0ed26b32c23bc23435b4297da
(ASoC: add generic simple-card support)

cd04461e2f491c81d30fb3b234cf43db3f098103
(ASoC: sh: fsi: select simple-card on Kconfig)

590b4775d6b628c7ad215fd0335a0a787032e2dd
(ALSA: workaround: change the timing of alsa_sound_last_init())

cdf27f373781d8740b874b0b5c18142df32ebb52
(ASoC: fsi: update for dmaengine prep_slave_sg fallout.)

Best regards
---
Kuninori Morimoto
