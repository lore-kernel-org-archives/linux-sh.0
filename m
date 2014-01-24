From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:40:20 +0000
Subject: [PATCH V2 0/2] ARM: shmobile: Enable modules for Lager and Koelsch
Message-Id: <1390603222-13351-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables modules, module unloading and versioning
support in lager_defconfig and koelsch_defconfig

Changes in V2:
* enabled module unloading support.

Valentine Barshak (2):
  ARM: shmobile: lager: Enable modules in defconfig
  ARM: shmobile: koelsch: Enable modules in defconfig

 arch/arm/configs/koelsch_defconfig | 3 +++
 arch/arm/configs/lager_defconfig   | 3 +++
 2 files changed, 6 insertions(+)

-- 
1.8.3.1

