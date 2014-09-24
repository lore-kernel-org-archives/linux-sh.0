From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 24 Sep 2014 12:28:54 +0000
Subject: Re: [PATCH v2 0/3] Remove Koelsch board files
Message-Id: <6887699.yCMoF0u86l@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410965575-21188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410965575-21188-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 24 September 2014 09:33:21 Simon Horman wrote:
> On Wed, Sep 17, 2014 at 05:52:52PM +0300, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set (also know as "look at the diffstat and fall in love -
> > again") removes both the legacy and reference Koelsch board files, now
> > that the Koelsch board is supported by the r8a7791 generic DT platform.
> > 
> > The patches depend on the "[PATCH 0/8] DU DT support for Marzen, Lager and
> > Koelsch" series I've just posted, and are thus targeted at v3.19.
> 
> Wonderful, lets work on getting that dependency and this series in!

How would you like to merge the two series ? The DU driver dependency will be 
merged in v3.18-rc1, can you then merge "[PATCH 0/8] DU DT support for Marzen, 
Lager and Koelsch" (for which I've just sent a v2) and "[PATCH v2 0/3] Remove 
Koelsch board files" for v3.19, or should (part of) the first series be merged 
in v3.18-rc1 as well ?

> > Changes since v1:
> > 
> > - Remove legacy r8a7791-koelsch.dtb line from arch/arm/boot/dts/Makefile
> > 
> > Laurent Pinchart (3):
> >   ARM: mach-shmobile: koelsch: Remove legacy C board code
> >   ARM: mach-shmobile: r8a7791: Remove legacy code
> >   ARM: mach-shmobile: Remove the koelsch-reference board code
> >  
> >  arch/arm/boot/dts/Makefile                       |   1 -
> >  arch/arm/configs/koelsch_defconfig               | 113 -----
> >  arch/arm/configs/shmobile_defconfig              |   1 -
> >  arch/arm/mach-shmobile/Kconfig                   |  19 -
> >  arch/arm/mach-shmobile/Makefile                  |   3 -
> >  arch/arm/mach-shmobile/Makefile.boot             |   1 -
> >  arch/arm/mach-shmobile/board-koelsch-reference.c |  44 --
> >  arch/arm/mach-shmobile/board-koelsch.c           | 530 ------------------
> >  arch/arm/mach-shmobile/clock-r8a7791.c           | 342 ---------------
> >  arch/arm/mach-shmobile/r8a7791.h                 |   3 -
> >  arch/arm/mach-shmobile/setup-r8a7791.c           | 181 +-------
> >  11 files changed, 1 insertion(+), 1237 deletions(-)
> >  delete mode 100644 arch/arm/configs/koelsch_defconfig
> >  delete mode 100644 arch/arm/mach-shmobile/board-koelsch-reference.c
> >  delete mode 100644 arch/arm/mach-shmobile/board-koelsch.c
> >  delete mode 100644 arch/arm/mach-shmobile/clock-r8a7791.c

-- 
Regards,

Laurent Pinchart

