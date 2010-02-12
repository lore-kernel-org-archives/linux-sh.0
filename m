From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 12 Feb 2010 04:04:32 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7367 and G3EVM pinmux support
Message-Id: <20100212040432.GC7229@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100210111055.11130.83120.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100210111055.11130.83120.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 10, 2010 at 08:10:55PM +0900, Magnus Damm wrote:
> Add support for the sh7367 pinmux using drivers/sh/pfc.c
> and select serial console pins and some LEDs on G3EVM.

On Wed, Feb 10, 2010 at 08:13:31PM +0900, Magnus Damm wrote:
> Add G3EVM platform data and a magic setup sequence to
> initialize the r8a66597 block aka USBHS in sh7367.

These two have been applied, thanks.
