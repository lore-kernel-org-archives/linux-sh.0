From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Jan 2012 00:22:24 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 PINT IRQ base fix
Message-Id: <20120118002223.GE8182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120117110540.5414.77262.sendpatchset@w520>
In-Reply-To: <20120117110540.5414.77262.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 17, 2012 at 08:05:40PM +0900, Magnus Damm wrote:
> Bump up the sh73a0 PINT IRQ base from 768 to 800 to avoid
> collision with INTCS vectors for IRQ16->IRQ32 at 0x3xxx.
> 
> Without this fix the sh73a0 IRQ pin handling code collides
> with the PINT code which results in hangs on Kota2 during boot.

On Tue, Jan 17, 2012 at 08:10:49PM +0900, Magnus Damm wrote:
> Fix the sh73a0 external IRQ pin code to properly support
> CONFIG_SPARSE_IRQ=y by allocating IRQ descriptors for the
> cascaded IRQs associated with external IRQ pins.
> 
> Without this fix it is impossible to request IRQ0->IRQ31
> on the Kota2 board when sparse IRQs are enabled. 

On Tue, Jan 17, 2012 at 08:14:07PM +0900, Magnus Damm wrote:
> Now when GPIO IRQs are supported on sh73a0 modify the Kota2
> board code to switch from the polled "gpio-keys-polled" driver
> to the IRQ driven "gpio-keys" driver.

All applied, thanks.
