From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Thu, 06 Sep 2012 05:30:45 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: enable PMU(Performance Monitoring Unit)
Message-Id: <1346909447-12526-1-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1346813317-4030-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346813317-4030-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Hello, Simon-san

ARM core has hardware performance counters and perf command uses these counters for detailed profiling information.
The follewing patches enables PMU(Performance Monitoring Unit) for sh73a0 and emev2 SoCs. I tested these patches on kzm9g board and kzm9d board.

Tetsuyuki Kobayashi (2):
  ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit)
  ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit)

 arch/arm/configs/kzm9d_defconfig      |    1 +
 arch/arm/configs/kzm9g_defconfig      |    1 +
 arch/arm/mach-shmobile/setup-emev2.c  |   22 ++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |   22 ++++++++++++++++++++++
 4 files changed, 46 insertions(+)

-- 
1.7.9.5

