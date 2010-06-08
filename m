From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 08 Jun 2010 17:58:32 +0000
Subject: Re: [PATCH v2 0/4] Add support for new board: SH-2007
Message-Id: <AANLkTil4xPpv0vUhtZA5JySg4Y4AQFbaoGqMV8d8J-vp@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1275991727-4730-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275991727-4730-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2010/6/9 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>:
> Hi,
>
> 2010/6/8 Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>:
>> This patch series add support of SH-2007.
>> I brought these changes from the out-of-tree kernel
>> provided by the manufacture of this board, ITO Inc.
>> Website of company: http://www.itonet.co.jp/
>> The URL of kernel: http://ms-n.org/sh-linux/kernel/
>>
>> Adding support of new board is trivial,
>> but as I'll describe, 4/4 of this series contains
>> some dirty and mysterious fixes.
>>
>> According to Paul's advice, I rewrote this patch series.
>> New points are described in each patch.
>> Request for comments!
>>
>> Hitoshi Mitake (4):
>> =A0Add the directory mach-sh2007 for SH-2007 board support
>> =A0Add sh2007_defconfig for default configuration of SH-2007
>> =A0Add Kconfig and Makefile for SH-2007 support
>> =A0Modify sh-sci.h to adopt specific serial behaviour of SH-2007
>>
>> =A0arch/sh/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0arch/sh/boards/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> =A0arch/sh/boards/mach-sh2007/Makefile | =A0 =A01 +
>> =A0arch/sh/boards/mach-sh2007/setup.c =A0| =A0314 ++++++++
>> =A0arch/sh/configs/sh2007_defconfig =A0 =A0| 1482 ++++++++++++++++++++++=
+++++++++++++
>> =A0drivers/serial/sh-sci.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 +-
>> =A06 files changed, 1822 insertions(+), 4 deletions(-)
>> =A0create mode 100644 arch/sh/boards/mach-sh2007/Makefile
>> =A0create mode 100644 arch/sh/boards/mach-sh2007/setup.c
>> =A0create mode 100644 arch/sh/configs/sh2007_defconfig
>
> You forgot to update tools/mach-types.
>
> Subject: [PATCH] sh: Add sh2007 board to tools/mach-types
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
> =A0arch/sh/tools/mach-types | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
> index b25aa55..e563353 100644
> --- a/arch/sh/tools/mach-types
> +++ b/arch/sh/tools/mach-types
> @@ -60,3 +60,4 @@ ESPT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SH_ESPT
> =A0POLARIS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SH_POLARIS
> =A0KFR2R09 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SH_KFR2R09
> =A0ECOVEC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SH_ECOVEC
> +SH2007 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SH_2007
> --
> 1.7.1
>
update patch.
---

diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index b25aa55..e563353 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -60,3 +60,4 @@ ESPT			SH_ESPT
 POLARIS			SH_POLARIS
 KFR2R09			SH_KFR2R09
 ECOVEC			SH_ECOVEC
+SH2007			SH_SH2007
