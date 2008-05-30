From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 30 May 2008 04:59:28 +0000
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Message-Id: <20080530135928.9a555aca.iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org

Hi, Magnus.

On Thu, 29 May 2008 18:24:51 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch adds frame buffer support for the LCDC block found in
> SuperH Mobile processors. The hardware supports up to two LCD panels
> per LCDC block, and both RGB and SYS interfaces can be used to hook
> up LCD panels/modules.
> 
> The device driver is a regular platform driver, so LCD configuration
> and board specific hooks are passed to the driver using platform data.
> LCD modules using SYS interface often require special configuration
> using the SYS bus, and to solve this cleanly the driver provides SYS
> interface operations to the board code.
> 
> Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> WVGA panels using RGB16 and RGB18 interfaces.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  drivers/video/Kconfig            |   10 
>  drivers/video/Makefile           |    2 
>  drivers/video/sh_mobile_lcdcfb.c |  742 ++++++++++++++++++++++++++++++++++++++
>  include/asm-sh/sh_mobile_lcdc.h  |   66 +++

This is a proposal. 
I am coding sh7763's frame buffer driver.
I think that the number of FB drivers of SH will increase in the future. 
I think that I want to make the driver/video/sh directory, and to bring 
SH together in this directory for the future.
Do you think about it?

Best regards,
 Nobuhiro
 
-- 
Nobuhiro Iwamatsu
