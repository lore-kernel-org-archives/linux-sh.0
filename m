From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Oct 2015 04:59:31 +0000
Subject: Remove Renesas sound SRU for Gen1 support
Message-Id: <87r3ldswdb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


Hi ALSA, and SH ML

I would like to remove Renesas sound SRU support of Gen1 in the future.
It was created for preparation of Gen2 SRC support, and it converts sampling
rate. But no-one is using this feature in Gen1.
board-bockw had used SRU before, but it was pass through mode. This means it is
same as SSI. 2nd reason is that board-bockw was removed from upstream code.
BockW is now supported by DT, but it doesn't use SRU.
More detail, r8a7778.dtsi has rcar_sound,src entry, but no-one is using this
feature. SRU proving has no relation to this removing feature. This means
there is no effect for DT compatibility.

Gen2 SRC was created from Gen1 SRU, these are similar but not same IP.
Keeping Gen1 SRU in current driver is a little bit difficult,
and no-one is using it today.
Gen1 sound is still supported via SSI.
If there is no objection, I would like to remove it from upstream
 step1. add warning message in v4.x
 step2. remove it in v4.x+1

Best regards
---
Kuninori Morimoto
