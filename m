From: Rich Felker <dalias@libc.org>
Date: Fri, 15 Jul 2016 15:41:12 +0000
Subject: Re: [PATCH v3 08/12] irqchip: add J-Core AIC driver
Message-Id: <20160715154112.GS15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <05a5be0a4f1471272dcdd2259e4d97642ee43759.1464148904.git.dalias@libc.org>
 <CAP=VYLpWZmLHvTa0=bb9i4J5U=OMpNOM33Nx6C1zSMKzNCrf9g@mail.gmail.com>
In-Reply-To: <CAP=VYLpWZmLHvTa0=bb9i4J5U=OMpNOM33Nx6C1zSMKzNCrf9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jul 15, 2016 at 11:35:55AM -0400, Paul Gortmaker wrote:
> > +++ b/drivers/irqchip/irq-jcore-aic.c
> > @@ -0,0 +1,95 @@
> > +/*
> > + * J-Core SoC AIC driver
> > + *
> > + * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/io.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/module.h>
> 
> Please don't use module.h or MODULE_* in code that is controlled by
> a bool Kconfig.

Thanks for catching this. Fixed.

Rich
