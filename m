From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Dec 2014 23:16:26 +0000
Subject: [PATCH v4 0/3] Add R8A7791/Henninger board CAN DT support
Message-Id: <6830301.90YaDPuTpx@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20141223-v3.19-rc1' tag. Here we add the CAN device tree support
for the R8A7791-based Henninger board. It depends on the clk driver RCAN clock
patch posted recently in order to work.

[1/3] ARM: shmobile: r8a7791: add CAN clocks
[2/3] ARM: shmobile: r8a7791: add CAN DT support
[3/3] ARM: shmobile: henninger: add CAN0 DT support

WBR, Sergei

