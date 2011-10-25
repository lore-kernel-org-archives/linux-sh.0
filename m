From: kuninori.morimoto.gx@renesas.com
Date: Tue, 25 Oct 2011 00:44:25 +0000
Subject: Question about clk->usecount
Message-Id: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SH ML

renesas_usbhs and sh_eth seems break in SH7724 ecovec board
from 794d78fea51504bad3880d14f354a9847f318f25 (drivers: sh: late disabling of clocks V2)
So I debuged it.

when these driver call pm_runtime_get_sync(),
then, arch/sh/kernel/cpu/hwblk.c :: hwblk_enable() are called,
and it enabled MSTP bit.
This is OK.

But clk_late_init() disabled it.

Does hwblk/pm_runtime (?) not care clk->usecount ?
