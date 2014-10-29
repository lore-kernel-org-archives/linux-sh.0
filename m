From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Oct 2014 23:54:09 +0000
Subject: Re: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <20141029235409.GC4599@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141028004131.GA8280@verge.net.au>
In-Reply-To: <20141028004131.GA8280@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 10:31:47PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Oct 29, 2014 at 3:08 AM, Simon Horman <horms@verge.net.au> wrote:
> > rcar_thermal rcar_thermal: Runtime PM disabled, clock forced on.
> > rcar_thermal rcar_thermal: 3 sensor probed
> > sh_mobile_sdhi sh_mobile_sdhi.0: Runtime PM disabled, clock forced on.
> 
> BTW, any specific reason CONFIG_PM_RUNTIME is not enabled in
> ape6evm_defconfig?

I noticed that too and I don't think there is a reason.
I'll see about enabling it.
