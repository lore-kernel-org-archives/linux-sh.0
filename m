From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 19 Dec 2013 17:57:21 +0000
Subject: [PATCH 0/2] arm: shmobile: Add SATA support for Lager board
Message-Id: <1387475843-25849-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This adds SATA0/1 clocks to R8A7790 SoC and adds SATA1 to Lager board.
SATA0 is not available on Lager since MD23 selection is fixed to USB3.

It depends on the following commit available in the libata git tree:
https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfor-=
3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3

Valentine Barshak (2):
  arm: shmobile: r8a7790: Add SATA clock
  arm: shmobile: lager: Add SATA support

 arch/arm/mach-shmobile/board-lager.c   | 17 +++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

--=20
1.8.3.1

