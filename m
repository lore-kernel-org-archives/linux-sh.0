From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 29 Dec 2014 22:03:10 +0000
Subject: [PATCH 0/2] Add R8A7790 CAN DT support
Message-Id: <2616635.bsb7mLynhA@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141229-v3.19-rc2' tag. Here we add the CAN device tree support
for the R8A7790 SoC (unfortunately, it's impossible to test CAN on the Lager
board). It depends on the clk driver RCAN clock patch posted recently in order
to work.

[1/2] ARM: shmobile: r8a7790: add CAN clocks
[2/2] ARM: shmobile: r8a7790: add CAN DT support

WBR, Sergei

