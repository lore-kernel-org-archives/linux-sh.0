From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 29 Jan 2009 00:49:30 +0000
Subject: Re: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and
Message-Id: <1233190170.6734.36.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1233186456.6734.16.camel@localhost.localdomain>
	 <1233187069.6734.21.camel@localhost.localdomain>
	 <1233187750.6734.27.camel@localhost.localdomain>
	 <200901281944.57894.vapier@gentoo.org>
In-Reply-To: <200901281944.57894.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

On Wed, 2009-01-28 at 19:44 -0500, Mike Frysinger wrote:
> On Wednesday 28 January 2009 19:09:10 Adrian McMenamin wrote:
> > +static struct maple_driver vmu_flash_driver = {
> > +	.function =	MAPLE_FUNC_MEMCARD,
> > +	.drv = {
> > +		.name =		"Dreamcast_visual_memory",
> 
> i thought there was like a 16byte limit or something on this ?


Don't think so, it's just a const char* isn't it?

