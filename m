From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 14 Nov 2013 22:14:38 +0000
Subject: [PATCH 0/2] Add Ether support for R8A7791/Koelsch board
Message-Id: <201311150214.46245.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.12-20131112' tag. Here we add the Ether support to the
R8A7791/Koelsch board. The patchset requires the 'sh_eth' driver R8A7791
support patch posted earlier in order to work.

[1/3] ARM: shmobile: r8a7791: add Ether clock
[2/3] ARM: shmobile: Koelsch: add Ether support
[3/3] ARM: shmobile: Koelsch: enable Ether in defconfig

WBR, Sergei
