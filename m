From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 02 Jul 2014 22:39:14 +0000
Subject: [PATCH 0/2] Add R8A7791/Henninger board CAN DT support
Message-Id: <201407030239.15921.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.16-rc3-20140701' tag. Here we add the CAN device tree support
for the R8A7791-based Henninger board. It depends on the PFC CAN support and
R-Car CAN device tree support patches posted yesterday in order to work.

[1/2] ARM: shmobile: r8a7791: add CAN DT support
[2/2] ARM: shmobile: henninger: add CAN0 DT support

WBR, Sergei
