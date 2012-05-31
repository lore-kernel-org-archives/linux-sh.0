From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:28:48 +0000
Subject: [PATCH 0/2] ARM: mach-shmobile: kzm9g: add FSI DMAEngine support
Message-Id: <87ehq18a82.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871umdaqrd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871umdaqrd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Paul
Cc Magnus, Simon

These are kzm9g FSI DMAEngine support

Kuninori Morimoto (2):
      ARM: mach-shmobile: sh73a0: add MPDMAC support
      ARM: mach-shmobile: kzm9g: add FSI DMAEngine support

These patch set are base on my
[ARM: mach-shmobile: kzm9g: add FSI support] patch set

compile/boot is OK, but these need ASoC v3.5-rcX merge for FSI sound.
Without this merge, 2) sound is noisy.

fbe42f6		ASoC: fsi: bugfix: ensure dma is terminated
4a1b09b		ASoC: fsi: bugfix: correct dma area


Best regards
---
Kuninori Morimoto
