From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Dec 2013 00:18:56 +0000
Subject: [PATCH 0/4] Minor fixes and improvements for kexec
Message-Id: <cover.1386807069.git.geoff@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Biederman <ebiederm@xmission.com>
Cc: linux-sh@vger.kernel.org, kexec@lists.infradead.org, Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

Hi Eric,

Here are a few minor fixes and improvements for kexec.  Please consider.

-Geoff

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git for-kexec

for you to fetch changes up to 594a3d26aac66e9668edc81d7bfb4e801575514f:

  sh/kexec: Fix kexec build warning (2013-12-11 16:03:27 -0800)

----------------------------------------------------------------
Geoff Levand (4):
      kexec: Simplify conditional
      kexec: Add IND_FLAGS macro
      powerpc/kexec: Use global IND_FLAGS macro
      sh/kexec: Fix kexec build warning

 arch/powerpc/kernel/machine_kexec_64.c |  2 --
 arch/sh/kernel/machine_kexec.c         |  2 +-
 include/linux/kexec.h                  |  1 +
 kernel/kexec.c                         | 17 ++++++++++-------
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
1.8.1.2

