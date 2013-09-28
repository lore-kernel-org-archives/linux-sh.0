From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Sep 2013 00:41:51 +0000
Subject: [PATCH 0/2] Add CAN0 support for R8A7778/BOCK-W board
Message-Id: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20130927v2' tag. Here we add the CAN0 controller support working
on the R8A7778/BOCK-W board. The patchset requires the 'rcar_can' driver and 
R8A7778 PFC patch posted earlier in order to compile and/or work.

[1/2] ARM: shmobile: r8a7778: add CAN clock support
[2/2] ARM: shmobile: BOCK-W: add CAN0 support

   Unfortunately, the use of CAN is much hindered by the fact that the CAN0
signals use the BOCK-W's product serial port and CAN1 pins are not connected.

WBR, Sergei
