From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jul 2015 00:25:43 +0000
Subject: [PATCH 0/4] ARM: shmobile: r8a779x: Add CTU/MIX support
Message-Id: <87twsycqb5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ny1ig.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ny1ig.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Latest ALSA SoC branch includes CTU/MIX support.
This patch-set enables these on r8a7790/r8a7791.
This advanced feature is assuming to be used via rsrc-card sound card,
since it needs DPCM on sound card,

It is not used on upstream:ed Lager/Koelsh at this point.
Because, 1) These CTU/MIX is still prototype, 2) it needs to exchange sound
card driver.

git branch
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: topic/rcar

cgit
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=topic/rcar

Kuninori Morimoto (4):
      ARM: shmobile: r8a7790: Add Audio CTU support on DTSI
      ARM: shmobile: r8a7790: Add Audio MIX support on DTSI
      ARM: shmobile: r8a7791: Add Audio CTU support on DTSI
      ARM: shmobile: r8a7791: Add Audio MIX support on DTSI

 arch/arm/boot/dts/r8a7790.dtsi            | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi            | 23 +++++++++++++++++++++++
 include/dt-bindings/clock/r8a7790-clock.h |  2 ++
 include/dt-bindings/clock/r8a7791-clock.h |  2 ++
 4 files changed, 50 insertions(+)
