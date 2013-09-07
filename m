From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 07 Sep 2013 00:23:29 +0000
Subject: [PATCH v2 0/4] Add Ether DT support for R8A7778/BOCK-W reference board
Message-Id: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 4 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20130906' tag. Here we add the Ether device tree support working
on the R8A7778/BOCK-W reference board. The patchset requires the 'sh_eth' driver
device tree support posted earlier in order to work.

[1/4] ARM: shmobile: r8a7778: add Ether DT support
[2/4] ARM: shmobile: r8a7778: add Ether clock for DT case
[3/4] ARM: shmobile: bockw-reference: add Ether DT support
[4/4] ARM: shmobile: BOCK-W reference: add Ether PFC settings

WBR, Sergei
