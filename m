From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 12:23:49 +0000
Subject: [PATCH 0/2] ARM: shmobile: Enable modules for Lager and Koelsch
Message-Id: <1390566231-18928-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables modules and module versioning support
in lager_defconfig and koelsch_defconfig

Valentine Barshak (2):
  ARM: shmobile: lager: Enable modules in defconfig
  ARM: shmobile: koelsch: Enable modules in defconfig

 arch/arm/configs/koelsch_defconfig | 2 ++
 arch/arm/configs/lager_defconfig   | 2 ++
 2 files changed, 4 insertions(+)

-- 
1.8.3.1

