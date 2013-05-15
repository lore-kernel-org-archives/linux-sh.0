From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 May 2013 08:46:58 +0000
Subject: marzen pinctl conflict for renesas-next-20130515v2 + v3.10-rc1
Message-Id: <20130515084658.GA19115@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

I am preparing to rebase the branches of the renesas tree which
are targeted for v3.11 on top of v3.10-rc1. In the course of
doing so I have noticed a problem on the marzen board which appears
to be related to pinmux.

On boot, using the default config I see the following:

sh-pfc pfc-r8a7779: pin GP_4_22 already requested by sh-hspi.0; cannot claim for ehci-platform.0
sh-pfc pfc-r8a7779: pin-150 (ehci-platform.0) status -22
sh-pfc pfc-r8a7779: could not request pin 150 on device sh-pfc
ehci-platform ehci-platform.0: Error applying setting, reverse things back
Unable to handle kernel NULL pointer dereference at virtual address 00000036

Looking at pfc-r8a7779 and the SoC documentation it seems
that HSPI0 and USB0 do indeed use different functions of
GPIO pin 4 22 (and other pins too).

I am unsure how this should be managed by either the pinmux driver
or the board code.

For reference I have pushed a merge of renesas-next-20130515v2 and
v3.10-rc1 as renesas-next-20130515v2+v3.10-rc1. If you have a marzen
board you should be able to reproduce the problem with that tree.
