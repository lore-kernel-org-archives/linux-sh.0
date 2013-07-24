From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Jul 2013 08:07:00 +0000
Subject: Re: [PATCH 05/08] ARM: shmobile: Remove AG5EVM use of <mach/hardware.h>
Message-Id: <20130724080659.GK10027@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724033715.30567.82782.sendpatchset@w520>
 <20130724033801.30567.89261.sendpatchset@w520>
In-Reply-To: <20130724033801.30567.89261.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 24, 2013 at 12:38:01PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove unused <mach/hardware.h> on AG5EVM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I have skipped this patch as the cleanup2 branch, where I am applying
other patches in this series, includes a patch to remove AG5EVM.
