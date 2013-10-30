From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 30 Oct 2013 22:16:34 +0000
Subject: [PATCH 0/2] Add Ether support for R8A7791/Koelsch board
Message-Id: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.12-rc7-20131030' tag. Here we add the Ether support to the
R8A7791/Koelsch board. The patchset requires the R8A7791 PFC support posted
earlier in order to work.

[1/2] ARM: shmobile: r8a7791: add Ether clock
[2/2] ARM: shmobile: Koelsch: add Ether support

WBR, Sergei
