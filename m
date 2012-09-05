From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Wed, 05 Sep 2012 02:48:35 +0000
Subject: [PATCH 0/2] ARM: shmobile: enable PMU(Performance Monitoring Unit)
Message-Id: <1346813317-4030-1-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Hello, Simon-san

ARM core has hardware performance counters and perf command uses these counters for detailed profiling information.
The follewing patches enables PMU(Performance Monitoring Unit) for sh73a0 and emev2 SoCs. I tested these patches on kzm9g board and kzm9d board.

Tetsuyuki Kobayashi (2):
  ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit) 
  ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit) 

 arch/arm/mach-shmobile/setup-emev2.c  |   26 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |   26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

-- 
1.7.9.5

