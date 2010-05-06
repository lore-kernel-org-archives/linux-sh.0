From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 May 2010 05:17:08 +0000
Subject: Re: Discussion about register definition header
Message-Id: <20100506051708.GC25493@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201005021110.22111.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201005021110.22111.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, May 02, 2010 at 11:10:21AM +0200, Fabio Giovagnini wrote:
> I think that into include/asm dir shoud be a file containing ALL the mpu 
> registers address definitions, for avoiding to have same definitions across 
> different files and an high probability to write something wrong each time.
> I think this has not already done beacuse it is a long work for testing. Is it 
> the main reason?
> 
The main reason is that there's simply no need for it. Many of the CPUs
in question have similar register definitions but just position the
blocks at different locations. This is the sort of change that should be
managed between the driver and the CPU setup code in charge of
registering the SoC's platform devices.

For the most part we've evolved beyond simple hardcoded register
definitions, and the few cases where we still have to put up with them
now are mostly for blocks that aren't handled through the driver model.
Also note that these days almost everything needs to be remapped (either
via the TLB or via the PMB) so it's no longer possible to simply permit
drivers to do absurd P1/P2 abuses.

If you want to see what a total mess having these sorts of headers
quickly turns in to, you don't have to dig very far through the
architecture tree to find them. ARM used to do this via an
all-encompassing asm/hardware.h and has likewise moved on.
