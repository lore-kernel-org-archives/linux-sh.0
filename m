From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 05:29:21 +0000
Subject: Re: [PATCH v4 0/3] CPUFreq for sh73a0 / kzm9g, using cpufreq-cpu0
Message-Id: <20130327052919.GL25431@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364153255-20664-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1364153255-20664-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Mar 24, 2013 at 08:27:32PM +0100, Guennadi Liakhovetski wrote:
> The cpufreq-cpu0 CPUFreq driver has been recently been converted to a 
> platform driver, which made v3 of this patch set non-functional. This 
> version performs the necessary update and also modifies kzm9g-reference 
> AS3711 support to be suitable for the mainline by removing LCDC hacks.
> 
> Guennadi Liakhovetski (3):
>   ARM: shmobile: sh73a0: add support for adjusting CPU frequency
>   ARM: shmobile: add framebuffer and backlight support to
>     kzm9g-reference
>   ARM: shmobile: kzm9g-reference: add CPUFreq support
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   86 +++++++++++++++++++++++
>  arch/arm/mach-shmobile/Kconfig               |    2 +
>  arch/arm/mach-shmobile/clock-sh73a0.c        |   95 +++++++++++++++++++++++++-
>  arch/arm/mach-shmobile/setup-sh73a0.c        |    5 ++
>  4 files changed, 186 insertions(+), 2 deletions(-)

Magnus, can I get an Ack from you?
