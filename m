From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 05 Jan 2015 22:22:34 +0000
Subject: [PATCH v5 0/3] Add R8A7791/Henninger board CAN DT support
Message-Id: <1652479.NHBlqJ9OaR@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141231-v3.19-rc2' tag. Here we add the CAN device tree support
for the R8A7791-based Henninger board. It depends on the clk driver RCAN clock
patch reposted today in order to work.

[1/3] ARM: shmobile: r8a7791: add CAN clocks
[2/3] ARM: shmobile: r8a7791: add CAN DT support
[3/3] ARM: shmobile: henninger: add CAN0 DT support

WBR, Sergei

