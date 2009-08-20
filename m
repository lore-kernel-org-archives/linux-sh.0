From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 Aug 2009 23:45:04 +0000
Subject: Re: [PATCH] sh: i2c compile fix for kfr2r09
Message-Id: <20090820234504.GC31542@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090820135736.23974.96123.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090820135736.23974.96123.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2009 at 10:57:36PM +0900, Magnus Damm wrote:
> Fix the kfr2r09 board code so it compiles if CONFIG_I2C=n.

On Thu, Aug 20, 2009 at 10:58:38PM +0900, Magnus Damm wrote:
> Add instruction cache and TLB invalidation code for the
> the kfr2r09 romimage target.

On Thu, Aug 20, 2009 at 10:59:26PM +0900, Magnus Damm wrote:
> Add a P1 jump to the the kfr2r09 romimage code. With this
> patch applied the initial zImage assembly code will run
> with instruction cache enabled.

On Thu, Aug 20, 2009 at 11:01:24PM +0900, Magnus Damm wrote:
> Add romImage defconfig for the kfr2r09 board. This defconfig
> should be used to build the kernel based boot loader.

On Thu, Aug 20, 2009 at 11:02:24PM +0900, Magnus Damm wrote:
> Update the kfr2r09 defconfig with support for LCDC and USB gadget.

All applied, thanks.
