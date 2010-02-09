From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Feb 2010 09:21:52 +0000
Subject: Re: [PATCH 00/03] ARM: mach-shmobile: INTCA patches
Message-Id: <20100209092152.GA17722@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100209033533.22732.2030.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100209033533.22732.2030.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 09, 2010 at 12:35:33PM +0900, Magnus Damm wrote:
> ARM: mach-shmobile: INTCA support
> 
> [PATCH 01/03] ARM: mach-shmobile: sh7367 INTCA support
> [PATCH 02/03] ARM: mach-shmobile: sh7377 INTCA support
> [PATCH 03/03] ARM: mach-shmobile: sh7372 INTCA support
> 
> These patches add support for the INTCA harware block in
> sh7367, sh7377 and sh7372 using INTC tables. The INTCA
> hardware block is an interrupt controller for all on-chip
> peripherals and external interrupt sources that connect
> to the ARM core. Interrupt sources tied to the SH core
> using the INTCS interrupt controller are not supported yet.
> 
Applied, thanks.
