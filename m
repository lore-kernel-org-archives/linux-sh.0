From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Date: Mon, 26 Oct 2015 09:40:27 +0000
Subject: Re: Possible Regression due to c074fef5d36e ("of/platform: Defer probes of registered devices").
Message-Id: <20151026094027.GA25225@gradator.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20151026032039.GA1950@verge.net.au>
In-Reply-To: <20151026032039.GA1950@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello Simon,

On Mon, Oct 26, 2015 at 12:20:39PM +0900, Simon Horman wrote:
> Hi,
> 
> I have observed a possible regression in next-20151022
> due to c074fef5d36e ("of/platform: Defer probes of registered devices").
> 
> The problem manifests on the r8a7791 based koelsch board.
> With the above patch present booting the board using the shmobile_defconfig
> results in no console output. While after reverting the above patch
> the boot proceeds all the way to user-space.
> 
> With DEBUG_LL and EARLY_PRINTK enabled I was able to capture some console
> output. I have included both that boot log, and a log of boot all the way to
> userspace with the patch in question reverted.
> 
> The problem does not seem to manifiest on other boards for other
> Renesas ARM  SoCs that I have access too. In particular the
> r8a7790 based lager board; the r8a7790 and r8a7791 are both members
> of the R-Car Gen2 family of SoCs.

Atmel SoC hit this regresssion too, discussion about this issue is in 
the following thread:
 https://lkml.org/lkml/2015/10/16/733

Sylvain
