From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Dec 2015 05:35:51 +0000
Subject: [PATCH 0/2] arm64: renesas: CS2000 support for sound
Message-Id: <87lh9eybq9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

CS2000 driver was accepted in clk-next
https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/log/?h=clk-next

These patches add cs2000 support on salvator-x board for sound.

Kuninori Morimoto (2):
      arm64: renesas: salvator-x: use CS2000 as AUDIO_CLK_B
      arm64: defconfig: add CS2000 support

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                       |  1 +
 2 files changed, 39 insertions(+)


Best regards
---
Kuninori Morimoto
