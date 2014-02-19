From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Feb 2014 22:18:21 +0000
Subject: [PATCH v2 0/2] Add Ether DT support for R8A7790/Lager reference board
Message-Id: <201402200218.23099.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-rc3-20140218' tag. Here we add the Ether device tree
support on the R8A7790/Lager reference board. The patchset requires the
'sh_eth' driver device tree support just merged to the 'net-next.git' repo in
order to work.

[1/2] ARM: shmobile: r8a7790: add Ether DT support
[2/2] ARM: shmobile: lager: add Ether DT support

WBR, Sergei
