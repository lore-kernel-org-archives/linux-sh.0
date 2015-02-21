From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 21 Feb 2015 22:25:09 +0000
Subject: [PATCH 0/2] Add R8A7794/SILK board SDHI DT support
Message-Id: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20150220-v3.19' tag. Here we add the SDHI device tree support
for the R8A7794-based SILK board. It depends on the other R8A7794/SILK patches
in order to apply, on the R8A7794 GPIO patches in order to apply/compile, and
on the R8A7794 SDHI PFC driver patch in order for the pins to be configured.

[1/2] ARM: shmobile: r8a7794: add SDHI DT support
[2/2] ARM: shmobile: silk: add SDHI0/1 DT support

WBR, Sergei

