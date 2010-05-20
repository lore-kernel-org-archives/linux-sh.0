From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 May 2010 03:46:22 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: g3evm: Add IrDA support
Message-Id: <20100520034622.GH6661@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ueihglic5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <ueihglic5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 13, 2010 at 10:07:54AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-g3evm.c |   33 +++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
> 
It should be noted that sh_sir presently is only built for SH and not
ARCH_SHMOBILE. Adding ARCH_SHMOBILE blocks up on the asm/clock.h include
and shows that the driver itself is using deprecated clock lookups. While
none of this matters for the platform device data, you'll still need to
post a patch that tidies up the sh_sir driver and allows us to enable it
for the ARCH_SHMOBILE case.
