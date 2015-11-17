From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 03:18:32 +0000
Subject: [PATCH 00/04] pinctrl: sh-pfc: r8a7794: DU support
Message-Id: <20151117031832.24924.60685.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, horms@verge.net.au, geert@glider.be, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

pinctrl: sh-pfc: r8a7794: DU support

[PATCH 01/04] pinctrl: sh-pfc: r8a7794: Add DU pin groups
[PATCH 02/04] pinctrl: sh-pfc: r8a7794: Separate DU CDE and DISP
[PATCH 03/04] pinctrl: sh-pfc: r8a7794: Add missing dot clock signals
[PATCH 04/04] pinctrl: sh-pfc: r8a7794: Break out ODDF from sync

These patches take the r8a7794 PFC DU support code from the BSP
and reworks it to fit the r8a7794 ALT board. Tested with the ALT
VGA port - by default PFC is not used however enabling PFC using
an incremental (yet to be posted) patch works well.

It is worth noting that patch 2-4 modifies the pin groups. This
means that the upstream DT ABI for PFC DU will differ compared
to the unreviewed BSP code.

In general it is not considered good practice to change the pin
groups and break compatibility since they are part of the DT ABI.

For this particular case upstream never have had PFC DU support
for r8a7794, so treating the BSP bindings as experimental and
migrate away seems reasonable.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against v4.4-rc1

 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  282 ++++++++++++++++++++++++++++++----
 1 file changed, 252 insertions(+), 30 deletions(-)
