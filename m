From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 17 Apr 2012 07:43:54 +0000
Subject: Re: [PATCH 1/2] sh: Add initial support for SH7734 CPU subtype
Message-Id: <20120417074354.GC25751@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1332993899-15946-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1332993899-15946-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 12, 2012 at 03:45:32PM +0900, Nobuhiro Iwamatsu wrote:
> This implements initial support for the SH7734.
> This adds support SCIF, TMU and RTC.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
> 
> V3: Remove support for HCI-SH and I2C.
>     Change to use the div4 clock API. 
>     Change to use SCIx_IRQ_MUXED().
> V2: Fix build clock framework on 3.4-rc2

On Thu, Apr 12, 2012 at 03:45:33PM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  arch/sh/kernel/cpu/sh4a/Makefile        |    1 +
>  arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c | 2497 +++++++++++++++++++++++++++++++
>  2 files changed, 2498 insertions(+), 0 deletions(-)
>  create mode 100644 arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c

Both applied, thanks.
