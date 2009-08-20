From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Aug 2009 01:51:27 +0000
Subject: Re: [PATCH] sh: Add EcoVec (SH7724) board support
Message-Id: <20090820015126.GB27450@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ufxbo57lq.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ufxbo57lq.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 09:08:33PM +0900, Kuninori Morimoto wrote:
> This adds preliminary support for the EcoVec board.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/Makefile                      |    1 +
>  arch/sh/boards/Kconfig                |    7 +
>  arch/sh/boards/mach-ecovec24/Makefile |    9 +
>  arch/sh/boards/mach-ecovec24/setup.c  |  129 +++
>  arch/sh/configs/ecovec24_defconfig    | 1550 +++++++++++++++++++++++++++++++++
>  5 files changed, 1696 insertions(+), 0 deletions(-)
>  create mode 100644 arch/sh/boards/mach-ecovec24/Makefile
>  create mode 100644 arch/sh/boards/mach-ecovec24/setup.c
>  create mode 100644 arch/sh/configs/ecovec24_defconfig
> 
Applied, thanks.

In the future, please do not forget to add the board entry to
arch/sh/tools/mach-types, this saves me from having to always add them
manually. :-)
