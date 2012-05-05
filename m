From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 05 May 2012 19:50:01 +0000
Subject: Re: [PATCH 00/02] mach-shmobile: Emma Mobile EV2 - first shot
Message-Id: <201205051950.01887.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <201205051921.13209.arnd@arndb.de> <201205052130.21081.rjw@sisk.pl>
In-Reply-To: <201205052130.21081.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Saturday 05 May 2012, Rafael J. Wysocki wrote:
> > All the chips in there so far share a common ancestry and they all use a
> > significant subset of the same drivers shared with arch/sh: i2c-sh_mobile,
> > sh-dma-engine, sh_cmt, sh-sci, sh_tmu, intc, pfc and sh_clk. AFAICT, this one
> > uses none of those and apparently was developed by NEC before the merger with
> > Renesas.
> 
> I see.  So your opinion is that it may have more in common with the other
> ARM-based platforms?

Not with any one in particular, although there are a lot of similarities between
recent Cortex-A9 based designs. I just think it would be more logical to put the
files into a new mach-emma directory in the same way that every other family has
its own directory.

As I said, I don't mind if you share infrastructure with mach-shmobile, like
using the same mach/*.h header files, but if you end up sharing actual code,
it would be nicer to put it into some location where it can also be shared by
other platforms.

	Arnd
