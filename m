From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Aug 2015 22:20:42 +0000
Subject: [PATCH 0/2] Add VIN and ADV7180 device tree support for R8A7794/SILK board
Message-Id: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

   Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
'renesas-devel-20150819-v4.2-rc7' tag. Here we add the VIN and ADV7180
video decoder device tree support on the R8A7794/SILK board. The patchset
requires previously posted SILK SDHI1 support patch in order to apply and 
R8A7794/SILK I2C1 support in order to apply and build.

[1/2] ARM: shmobile: r8a7794: add VIN DT support
[2/2] ARM: shmobile: silk: add VIN0/ADV7180 DT support

MBR, Sergei

