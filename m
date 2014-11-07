From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Nov 2014 15:51:06 +0000
Subject: [PATCH v7 0/2] clk: shmobile: DIV6 clock variable parent support
Message-Id: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, mturquette@linaro.org, geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, devicetree@vger.kernel.org, mark.rutland@arm.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

As Geert suggested, this revision fixes the number of parent clocks at one,
four, or eight to avoid ambiguity.

CU
Uli


Changes since v6:
- require exactly one, four, or eight parent clocks

Changes since v5:
- straighten types
- don't use hw->init outside cpg_div6_clock_init()
- drop superfluous allocation error messages
- drop renesas,src-* properties, can be inferred

Changes since v4:
- implement .get_parent, .set_parent
- improve bindings documentation

Changes since v3:
- note that renesas,src-shift and renesas,src-width depend on each other
- clarified description
- minor coding style fixes

Changes since v2:
- add r8a73a4 to bindings
- use u32 where appropriate
- don't split error message

Changes since v1:
- make sure unrelated register bits are preserved
- use the plural for the clocks property in bindings

Ulrich Hecht (2):
  clk: shmobile: div6: support selectable-input clocks
  clk: shmobile: document DIV6 clock parent bindings

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  18 ++--
 drivers/clk/shmobile/clk-div6.c                    | 113 ++++++++++++++++++---
 2 files changed, 113 insertions(+), 18 deletions(-)

-- 
1.8.4.5

