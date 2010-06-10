From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Thu, 10 Jun 2010 03:29:29 +0000
Subject: Re: [PATCH v2 0/4] Add support for new board: SH-2007
Message-Id: <4C105C19.8080301@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1275991727-4730-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275991727-4730-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/09/10 02:58, Nobuhiro Iwamatsu wrote:
 > 2010/6/9 Nobuhiro Iwamatsu<iwamatsu@nigauri.org>:
 >> Hi,
 >>
 >> 2010/6/8 Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>:
 >>> This patch series add support of SH-2007.
 >>> I brought these changes from the out-of-tree kernel
 >>> provided by the manufacture of this board, ITO Inc.
 >>> Website of company: http://www.itonet.co.jp/
 >>> The URL of kernel: http://ms-n.org/sh-linux/kernel/
 >>>
 >>> Adding support of new board is trivial,
 >>> but as I'll describe, 4/4 of this series contains
 >>> some dirty and mysterious fixes.
 >>>
 >>> According to Paul's advice, I rewrote this patch series.
 >>> New points are described in each patch.
 >>> Request for comments!
 >>>
 >>> Hitoshi Mitake (4):
 >>>   Add the directory mach-sh2007 for SH-2007 board support
 >>>   Add sh2007_defconfig for default configuration of SH-2007
 >>>   Add Kconfig and Makefile for SH-2007 support
 >>>   Modify sh-sci.h to adopt specific serial behaviour of SH-2007
 >>>
 >>>   arch/sh/Makefile                    |    1 +
 >>>   arch/sh/boards/Kconfig              |   11 +
 >>>   arch/sh/boards/mach-sh2007/Makefile |    1 +
 >>>   arch/sh/boards/mach-sh2007/setup.c  |  314 ++++++++
 >>>   arch/sh/configs/sh2007_defconfig    | 1482 
+++++++++++++++++++++++++++++++++++
 >>>   drivers/serial/sh-sci.h             |   17 +-
 >>>   6 files changed, 1822 insertions(+), 4 deletions(-)
 >>>   create mode 100644 arch/sh/boards/mach-sh2007/Makefile
 >>>   create mode 100644 arch/sh/boards/mach-sh2007/setup.c
 >>>   create mode 100644 arch/sh/configs/sh2007_defconfig
 >>
 >> You forgot to update tools/mach-types.
 >>
 >> Subject: [PATCH] sh: Add sh2007 board to tools/mach-types
 >>
 >> Signed-off-by: Nobuhiro Iwamatsu<iwamatsu@nigauri.org>
 >> ---
 >>   arch/sh/tools/mach-types |    1 +
 >>   1 files changed, 1 insertions(+), 0 deletions(-)
 >>
 >> diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
 >> index b25aa55..e563353 100644
 >> --- a/arch/sh/tools/mach-types
 >> +++ b/arch/sh/tools/mach-types
 >> @@ -60,3 +60,4 @@ ESPT                  SH_ESPT
 >>   POLARIS                        SH_POLARIS
 >>   KFR2R09                        SH_KFR2R09
 >>   ECOVEC                 SH_ECOVEC
 >> +SH2007                 SH_2007
 >> --
 >> 1.7.1
 >>
 > update patch.
 > ---
 >
 > diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
 > index b25aa55..e563353 100644
 > --- a/arch/sh/tools/mach-types
 > +++ b/arch/sh/tools/mach-types
 > @@ -60,3 +60,4 @@ ESPT			SH_ESPT
 >   POLARIS			SH_POLARIS
 >   KFR2R09			SH_KFR2R09
 >   ECOVEC			SH_ECOVEC
 > +SH2007			SH_SH2007

Hi Iwamatsu-san,

Thanks for your patch!
In fact, I didn't know about mach-types.
Can I take your patch in my v3 series?
