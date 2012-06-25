From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:30:18 +0000
Subject: [PATCH 0/1][RFC] ARM: shmobile: r8a7740: basic PM domain support
Message-Id: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

This patch adds very basic PM domain support to Armadillo board.

On my debug, it seems accessed correctly to PM domain register.
(saved PM register value when power up/down. and printed it in safety timing)

I tested it on Armadillo board, and maybe OK from "register value" point of view.
But I can't check from "real voltage" point, since ...
 - I don't have measuring machine
 - Armadillo doesn't have measuring spot (?)

I added [RFC] on this patch, since I'm not good at PM frame work.

I tested it by

echo mem > /sys/power/state
