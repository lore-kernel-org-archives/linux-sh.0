From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 21 Feb 2015 22:10:19 +0000
Subject: [PATCH 0/2] Add R8A7794 GPIO DT support
Message-Id: <6954455.LyoCrfjM8R@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-20150220-v3.19' tag. Here we add the GPIO device tree support
for the R8A7794 SoC. It depends on the R8A7794 PFC/MMCIF device tree patches
posted recently in order to apply.

[1/2] ARM: shmobile: r8a7794: add GPIO clocks
[2/2] ARM: shmobile: r8a7794: add GPIO DT support

WBR, Sergei

