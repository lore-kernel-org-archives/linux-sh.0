From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Sep 2008 11:50:32 +0000
Subject: Re: [PATCH v2] mtd: sh_flctl: add support for Renesas SuperH FLCTL
Message-Id: <20080929115032.GC24836@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48D348FC.3060301@renesas.com> <20080921010713.GA2522@linux-sh.org>
In-Reply-To: <20080921010713.GA2522@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

On Sun, Sep 21, 2008 at 10:07:13AM +0900, Paul Mundt wrote:
> On Fri, Sep 19, 2008 at 03:38:52PM +0900, Yoshihiro Shimoda wrote:
> > Several Renesas SuperH CPU has FLCTL. The FLCTL support NAND Flash.
> > This driver support SH7723.
> > 
> > Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> > Acked-by: Paul Mundt <lethal@linux-sh.org>
> > ---
> > 
> > PATCH v2:
> >  - fix size of ioremap().
> > 
> >  drivers/mtd/nand/Kconfig     |    7 +
> >  drivers/mtd/nand/Makefile    |    1 +
> >  drivers/mtd/nand/sh_flctl.c  |  878 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mtd/sh_flctl.h |  125 ++++++
> >  4 files changed, 1011 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/mtd/nand/sh_flctl.c
> >  create mode 100644 include/linux/mtd/sh_flctl.h
> > 
> I'll merge the platform bits once this is applied. Optionally I can roll
> this in to my tree if dwmw2 acks it.

David?
