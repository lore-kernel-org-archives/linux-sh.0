From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 21 Aug 2009 08:26:26 +0000
Subject: Re: [PATCH] sh: Add initial support for SH7757 CPU subtype
Message-Id: <20090821082626.GA30795@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 21, 2009 at 04:30:28PM +0900, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  arch/sh/Kconfig                         |    7 +
>  arch/sh/Kconfig.debug                   |    1 +
>  arch/sh/include/asm/processor.h         |    2 +-
>  arch/sh/include/cpu-sh4/cpu/freq.h      |    4 +
>  arch/sh/include/cpu-sh4/cpu/sh7757.h    |  243 ++++
>  arch/sh/kernel/cpu/sh4/probe.c          |   11 +-
>  arch/sh/kernel/cpu/sh4a/Makefile        |    3 +
>  arch/sh/kernel/cpu/sh4a/clock-sh7757.c  |  130 ++
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c | 2019 +++++++++++++++++++++++++++++++
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c  |  513 ++++++++
>  arch/sh/kernel/setup.c                  |    2 +-
>  arch/sh/mm/Kconfig                      |    7 +-
>  drivers/serial/sh-sci.c                 |    3 +-
>  drivers/serial/sh-sci.h                 |   17 +
>  14 files changed, 2954 insertions(+), 8 deletions(-)
>  create mode 100644 arch/sh/include/cpu-sh4/cpu/sh7757.h
>  create mode 100644 arch/sh/kernel/cpu/sh4a/clock-sh7757.c
>  create mode 100644 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
>  create mode 100644 arch/sh/kernel/cpu/sh4a/setup-sh7757.c
> 
Applied, thanks.
