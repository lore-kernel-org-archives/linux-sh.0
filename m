From: Rich Felker <dalias@libc.org>
Date: Wed, 19 Oct 2016 17:48:29 +0000
Subject: [GIT PULL] arch/sh updates for 4.9
Message-Id: <20161019174829.GA5905@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Linus,

Please pull these minor changes for arch/sh.

Rich



The following changes since commit c8d2bc9bc39ebea8437fd974fdbc21847bb897a3:

  Linux 4.8 (2016-10-02 16:24:33 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-for-4.9

for you to fetch changes up to 99f453f875a5e207f38e92ced6ce3427433d5be2:

  sh: add earlycon support to j2_defconfig (2016-10-18 18:54:56 -0400)

----------------------------------------------------------------
Minor changes to improve J2 support and match Kconfig expectations of
other subsystems.

----------------------------------------------------------------
Rich Felker (3):
      sh: support CPU_J2 when compiler lacks -mj2
      sh: add Kconfig option for J-Core SoC core drivers
      sh: add earlycon support to j2_defconfig

 arch/sh/Makefile             |  2 +-
 arch/sh/boards/Kconfig       | 10 ++++++++++
 arch/sh/configs/j2_defconfig |  2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)
