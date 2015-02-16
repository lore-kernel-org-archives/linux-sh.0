From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 16 Feb 2015 22:57:37 +0000
Subject: [PATCH 0/2 resend] Add R8A7794/SILK board eMMC DT support
Message-Id: <29687119.ELU9MoH02q@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20150215-v3.19' tag. Here we add the eMMC device tree support
for the R8A7794-based SILK board. It depends on the other R8A7794/SILK patches
posted last week in order to apply, and on the R8A7794 MMCIF PFC driver patch
in order for the pins to be configured.

[1/2] ARM: shmobile: r8a7794: add MMCIF DT support
[2/2] ARM: shmobile: silk: add eMMC DT support

WBR, Sergei

