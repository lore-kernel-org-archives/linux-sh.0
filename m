From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 31 Oct 2014 15:01:34 +0000
Subject: [PATCH 0/2] clk: shmobile: DIV6 clock variable parent support
Message-Id: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, mturquette@linaro.org, laurent.pinchart+renesas@ideasonboard.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, devicetree@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

Here's a new attempt at implementing variable-parent 6-bit divider (DIV6)
clocks, this time using .get_parent and .set_parent.  Also, the bindings now
actually explain how to specify the parent clocks and feature a relevant
example.

CU
Uli

Changes since v1:
- implement .get_parent, .set_parent
- improve bindings documentation
- split patch in two


Ulrich Hecht (2):
  clk: shmobile: div6: support selectable-input clocks
  clk: shmobile: document DIV6 clock parent bindings

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  28 +++--
 drivers/clk/shmobile/clk-div6.c                    | 117 ++++++++++++++++++---
 2 files changed, 127 insertions(+), 18 deletions(-)

-- 
1.8.4.5

