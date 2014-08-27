From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Aug 2014 04:19:33 +0000
Subject: Re: [PATCH 00/06] ARM: shmobile: Kconfig and Makefile cleanups
Message-Id: <20140827041929.GA12976@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820133121.808.91022.sendpatchset@w520>
In-Reply-To: <20140820133121.808.91022.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 25, 2014 at 01:04:50PM +0900, Magnus Damm wrote:
> On Fri, Aug 22, 2014 at 12:05 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Aug 20, 2014 at 10:31:21PM +0900, Magnus Damm wrote:
> >> ARM: shmobile: Kconfig and Makefile cleanups
> >>
> >> [PATCH 01/06] ARM: shmobile: Consolidate GPIOLIB Kconfig bits
> >> [PATCH 02/06] ARM: shmobile: Introduce a Kconfig entry for R-Mobile
> >> [PATCH 03/06] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen1
> >> [PATCH 04/06] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen2
> >> [PATCH 05/06] ARM: shmobile: Cleanup pm-rcar.o build using Kconfig
> >> [PATCH 06/06] ARM: shmobile: Cleanup pm-rmobile.o build using Kconfig
> >>
> >> Update the ARM mach-shmobile Kconfig and Makefile to prepare for
> >> multiplatform support of R-Mobile SoCs. While at it do various
> >> cleanups - thanks to Simon Horman for suggesting using Kconfig
> >> for pm-rmobile.o. I applied the same idea to patch 5. Thanks to
> >> Geert Uytterhoeven for pointing out the mess in the Kconfig files,
> >> hopefully this cleanup series is a step in the right direction.
> >
> > Hi Magnus,
> >
> > could you let me know what the status of this series is?
> 
> Hi Simon,
> 
> Please use the V2 series, it should be OK as-is.
> 
> [PATCH v2 00/05] ARM: shmobile: Kconfig and Makefile cleanups V2
> 
> Thanks for your help!

Done, thanks.
