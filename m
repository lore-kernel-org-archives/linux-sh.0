From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 30 May 2008 05:15:54 +0000
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Message-Id: <20080530051554.GA21499@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080530135928.9a555aca.iwamatsu@nigauri.org>
In-Reply-To: <20080530135928.9a555aca.iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Folks,

On Fri, May 30, 2008 at 01:59:28PM +0900, Nobuhiro Iwamatsu wrote:
> Hi, Magnus.
> 
> On Thu, 29 May 2008 18:24:51 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > This patch adds frame buffer support for the LCDC block found in
> > SuperH Mobile processors. The hardware supports up to two LCD panels
> > per LCDC block, and both RGB and SYS interfaces can be used to hook
> > up LCD panels/modules.
> > 
> > The device driver is a regular platform driver, so LCD configuration
> > and board specific hooks are passed to the driver using platform data.
> > LCD modules using SYS interface often require special configuration
> > using the SYS bus, and to solve this cleanly the driver provides SYS
> > interface operations to the board code.
> > 
> > Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> > WVGA panels using RGB16 and RGB18 interfaces.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > ---
> > 
> >  drivers/video/Kconfig            |   10 
> >  drivers/video/Makefile           |    2 
> >  drivers/video/sh_mobile_lcdcfb.c |  742 ++++++++++++++++++++++++++++++++++++++
> >  include/asm-sh/sh_mobile_lcdc.h  |   66 +++
> 
> This is a proposal. 
> I am coding sh7763's frame buffer driver.

 I wrote a driver for the SH7760 LCDC 2 years ago. From a quick glance at
the respective datasheets it seems both 7760 and 7763 have identical
register layout.  Looking at Magnus' driver, the 7722/7723 LCDC seems to
be an extended version of the 7760/63 LCDC. Maybe we can unify them somehow?


	Manuel Lauss
