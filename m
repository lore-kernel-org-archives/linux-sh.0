From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 00:58:57 +0000
Subject: Re: [PATCH v3 1/2] ARM: shmobile: ape6evm: add DT reference
Message-Id: <20130710005857.GE32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373299498-10044-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373299498-10044-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 08, 2013 at 06:04:57PM +0200, Guennadi Liakhovetski wrote:
> This patch adds a sample DT-based APE6EVM "reference" implementation. The
> use of platform-specific C-code should be avoided with this configuration
> as much as possible.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v3: (former "PATCH v2 2/4")
> 1. same function name "r8a73a4_add_dt_devices()"
> 2. preserve device registration order in setup-r8a73a4.c to match r8a7790
> 3. don't use networking / NFS in bootargs
> 
>  arch/arm/boot/dts/Makefile                       |    1 +
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   33 ++++++++++
>  arch/arm/mach-shmobile/Kconfig                   |   11 ++++
>  arch/arm/mach-shmobile/Makefile                  |    1 +
>  arch/arm/mach-shmobile/Makefile.boot             |    1 +
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |   71 ++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h    |    1 +
>  arch/arm/mach-shmobile/setup-r8a73a4.c           |    9 ++-
>  8 files changed, 126 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
>  create mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c


Thanks, I have queued this up for v3.12 in the dt-ape6evm branch
with Magnus's Ack.  It should appear in renesas-next-20130710
