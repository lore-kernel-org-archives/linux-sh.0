From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 09 Jan 2014 15:23:19 +0000
Subject: [PATCH V2 0/4] ARM: shmobile: koelsh: Add SATA support
Message-Id: <1389281003-10253-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This adds SATA0/1 clocks to R8A7791 SoC and adds SATA0 to Koelsch board.
SATA1 is not available on Koelsch since MD24 selection is fixed to PCIe.

It depends on the following commit available in the libata git tree:
https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfor-=
3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3

Changes in V2:
 * capitalized ARM in the subject;
 * used zs_clk as parent clock for SATA, according to the feedback from Ren=
esas;
 * rebased on top of "ARM: shmobile: r8a7791: Wait for status on all MSTP c=
locks";
 * enabled SATA in koelsch_defconfig

Valentine Barshak (4):
  ARM: shmobile: r8a7791: Add ZS clock
  ARM: shmobile: r8a7791: Add SATA clocks
  ARM: shmobile: koelsch: Add SATA0 support
  ARM: shmobile: koelsch: Enable SATA in defconfig

 arch/arm/configs/koelsch_defconfig     |  4 +++-
 arch/arm/mach-shmobile/board-koelsch.c | 17 +++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7791.c |  8 ++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

--=20
1.8.3.1

