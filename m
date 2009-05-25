From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 May 2009 08:10:11 +0000
Subject: [PATCH 00/04] sh: share clock framework frequency table code
Message-Id: <20090525081011.7893.47950.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: share clock framework frequency table code 

[PATCH 01/04] sh: add pll_clk to sh7785
[PATCH 02/04] sh: add shared clock framework frequency table code
[PATCH 03/04] sh: use shared frequency tables on sh7785
[PATCH 04/04] sh: remove clk_ops->build_rate_table()

These patches modify the clkfwk topic branch with the following:
- break out sh7785 pll_clk to remove multiplier from frqmr_recalc()
- implement clk_rate_table_build() and clk_rate_table_round()
- hook in the above functions in the sh7785 code, drop ->build_rate_table()
- remove ->build_rate_table() callback since recalc() can be used instead

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/clock.h            |   19 ++++
 arch/sh/kernel/cpu/clock.c             |   77 +++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |  125 +++++++++++---------------------
 3 files changed, 138 insertions(+), 83 deletions(-)
