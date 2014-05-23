From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 23 May 2014 08:08:08 +0000
Subject: Re: R-CAR's arch
Message-Id: <1400832488.4451.1.camel@chaos.site>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522101938.51fec16f@endymion.delvare>
In-Reply-To: <20140522101938.51fec16f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi Simon,

Le Friday 23 May 2014 à 09:37 +0900, Simon Horman a écrit :
> On Fri, May 23, 2014 at 12:55:07AM +0200, Laurent Pinchart wrote:
> > On Thursday 22 May 2014 10:19:38 Jean Delvare wrote:
> > > I admit I don't really understand how SHMOBILE relates to ARM and
> > > SUPERH (which so far I thought were two different and totally
> > > independent architectures, but apparently I was wrong?)
> > 
> > CONFIG_SUPERH is defined for arch/sh only, and CONFIG_ARCH_SHMOBILE for 
> > arch/arm/mach-shmobile.
> 
> For Jean's benefit:
> 
> SUPERH is an architecture.
> SHMOBILE is the in-kernel name for ARM based SoCs from Renesas.
> 
> Some IP blocks are shared between both.
> Or more to the point SHMOBILE makes use of some (e.g. driver)
> code that was originally developed for use with SUPERH.

OK, I thought it was something like that, thanks for the confirmation.

-- 
Jean Delvare
SUSE L3 Support

