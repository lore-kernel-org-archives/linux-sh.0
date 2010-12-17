From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 17 Dec 2010 10:42:41 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix compile warning in mm/init.c
Message-Id: <20101217104241.GG20847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101215105924.23413.34629.sendpatchset@t400s>
In-Reply-To: <20101215105924.23413.34629.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 15, 2010 at 07:59:24PM +0900, Magnus Damm wrote:
> Turn down the warning noise from the compiler,
> basically a SH-Mobile specific version of the
> patch located in the RMK patch tracker:
> 
> 6484/1: "fix compile warning in mm/init.c",
> 
> Without this patch the following warning triggers:
> 
>  CC      arch/arm/kernel/sys_arm.o
> arch/arm/mm/init.c: In function 'mem_init':
> arch/arm/mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but argument 12 has type 'unsigned int'
>   CC      arch/arm/kernel/traps.o

On Fri, Dec 17, 2010 at 03:15:48PM +0900, Magnus Damm wrote:
> Fix interrupt priority level handling on SH-Mobile ARM.
> 
> SH-Mobile ARM platforms using multiple interrupt priority
> levels need this patch to fix a potential dead lock that
> may occur if multiple interrupts with different levels
> are pending simultaneously.
> 
> The default INTC configuration is to use the same priority
> level for all interrupts, so this issue does not trigger by
> default. It is however common for board code to override the
> interrupt priority for certain interrupt sources depending
> on the application. Without this fix such boards may lock up.
> 
> In detail, this patch updates the INTC code in entry-macro.S
> to make sure that the INTLVLA register gets set as expected.
> 
> To trigger this bug modify the board specific code to adjust
> the interrupt priority level for the ethernet chip. After
> changing the priority level simply use flood ping to drown
> the board with interrupts.
> 
> This patch applies to INTCA-based processors such as sh7372,
> sh7377 and sh7372. GIC-based processors are not affected.
> 
> Suitable for v2.6.37-rc and stable from v2.6.34 to v2.6.36.

Both applied to rmobile/urgent, thanks.
