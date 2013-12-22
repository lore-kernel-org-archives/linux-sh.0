From: takasi-y@ops.dti.ne.jp
Date: Sun, 22 Dec 2013 09:27:22 +0000
Subject: [PATCH 0/2] ARM: shmobile: koelsch: (1+1)GiB memory in DT
Message-Id: <1387704444-750-1-git-send-email-takasi-y@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

According to Koelsch hardware manual, it has memory
 1GiB DDR0 at 1_0000_0000
 1GiB DDR1 at 2_0000_0000
And, with its default configuration,
 0_4000_0000..0_7fff_0000 is mirror of 1_0000_0000..1_3fff_ffff.

So, defining
 1GiB at 0_4000_0000 (mirror of DDR0)
 1GiB at 2_0000_0000 (DDR1)
is suitable to support full 2GiB of memory with LPAE, retaining
compatibility to 32bit case.

Confirmed to boot and to see memory size of
750MiB with LPAE=n, HIGHMEM=n
  1GiB with LPAE=n, HIGHMEM=y
  2GiB with LPAE=y, HIGHMEM=y

Two patches are to be applied to each
 arch/arm/boot/dts/r8a7791-koelsch.dts
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts
and will lexically conflict with Laurent's dts consolidation for
multi-platform support. Please arrange them manually. > Simon.

---

Takashi Yoshii (2):
  ARM: shmobile: koelsch: (1+1)GiB memory in DT
  ARM: shmobile: koelsch-reference: (1+1)GiB memory in DT

 arch/arm/boot/dts/r8a7791-koelsch-reference.dts |    7 ++++++-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
1.7.9.5

