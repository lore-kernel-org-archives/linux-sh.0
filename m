From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 17:15:30 +0000
Subject: [PATCH 0/3] ARM: shmobile: various improvements
Message-Id: <1360689333-13525-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

The first patch from this series we can push upstream (would be nice if 
someone could test it before that). The second one is an RFC - if desired, 
we can also convert SDHI1 regulator to enable card-power switching on it. 
The third patch is a "nice to have" bunch of improvements for mackerel.

Thanks
Guennadi

Guennadi Liakhovetski (3):
  ARM: shmobile: add AS3711 PMIC platform data on kzm9g
  ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva
  ARM: shmobile: streamline mackerel SD and MMC devices

 arch/arm/mach-shmobile/board-armadillo800eva.c |   97 +++++++++++--
 arch/arm/mach-shmobile/board-kzm9g.c           |  193 +++++++++++++++++-------
 arch/arm/mach-shmobile/board-mackerel.c        |  104 +++++--------
 3 files changed, 263 insertions(+), 131 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
