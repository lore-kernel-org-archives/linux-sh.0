From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 May 2013 09:51:30 +0000
Subject: Re: [PATCH 2/2 v3] ARM: shmobile: r8a7790: add __initdata on resource and device data
Message-Id: <20130527095129.GA31428@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87li718cpi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li718cpi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Sun, May 26, 2013 at 05:54:04PM -0700, Kuninori Morimoto wrote:
> These data will be kmemdup()'ed on
> platform_device_add_resources() and platform_device_add_data()
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This appears to cause a build failure.

include/linux/platform_device.h: In function ‘r8a7790_add_standard_devices’:
arch/arm/mach-shmobile/setup-r8a7790.c:125: error: irqc0_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:121: error: irqc0_data causes a section type conflict
include/linux/platform_device.h: In function ‘r8a7790_pinmux_init’:
arch/arm/mach-shmobile/setup-r8a7790.c:49: error: r8a7790_gpio0_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:49: error: r8a7790_gpio0_platform_data causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:50: error: r8a7790_gpio1_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:50: error: r8a7790_gpio1_platform_data causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:51: error: r8a7790_gpio2_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:51: error: r8a7790_gpio2_platform_data causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:52: error: r8a7790_gpio3_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:52: error: r8a7790_gpio3_platform_data causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:53: error: r8a7790_gpio4_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:53: error: r8a7790_gpio4_platform_data causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:54: error: r8a7790_gpio5_resources causes a section type conflict
arch/arm/mach-shmobile/setup-r8a7790.c:54: error: r8a7790_gpio5_platform_data causes a section type conflict
