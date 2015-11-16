From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Nov 2015 12:28:10 +0000
Subject: Re: [PATCH v2 3/3] [media] include/media: move platform_data to linux/platform_data/media
Message-Id: <4084946.Zz4s9XrKbs@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <013152dcb3d4eaddd39aa4a37868430567bdc2d6.1447671420.git.mchehab@osg.samsung.com>
 <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
In-Reply-To: <b8bd73bedde742571b1ab8a7c0917a732dbf2ca1.1447671420.git.mchehab@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 16 November 2015 09:00:45 Mauro Carvalho Chehab wrote:
> Let's not mix platform_data headers with the core headers. Instead, let's
> create a subdir at linux/platform_data and move the headers to that
> common place, adding it to MAINTAINERS.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think we can also move some of the existing platform data headers to the same
place, but that could be a separate patch:

$ git grep linux/platform_data drivers/media/
drivers/media/platform/coda/coda-common.c:#include <linux/platform_data/coda.h>
drivers/media/platform/soc_camera/mx2_camera.c:#include <linux/platform_data/camera-mx2.h>
drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/camera-mx3.h>
drivers/media/platform/soc_camera/mx3_camera.c:#include <linux/platform_data/dma-imx.h>
drivers/media/platform/soc_camera/pxa_camera.c:#include <linux/platform_data/camera-pxa.h>
drivers/media/platform/soc_camera/rcar_vin.c:#include <linux/platform_data/camera-rcar.h>

	Arnd
