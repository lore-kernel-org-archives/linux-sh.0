From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Oct 2014 00:12:58 +0000
Subject: Re: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <20141029001258.GE20702@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141028004131.GA8280@verge.net.au>
In-Reply-To: <20141028004131.GA8280@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 28, 2014 at 10:32:32AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Oct 28, 2014 at 10:23 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Oct 28, 2014 at 08:59:28AM +0100, Geert Uytterhoeven wrote:
> >> On Tue, Oct 28, 2014 at 1:41 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > I have noticed that there appears to be a regression between v3.17 and
> >> > v3.18-rc1 such that non-multiplatform APE6EVM (ape6evm_defconfig) no longer
> >> > boots.  This appears to be the case using both reference DT (MACH_APE6EVM)
> >>
> >> How does it manifest itself?
> >> If you don't get any console output, have you tried my early debug patch?
> >
> > IIRC, there was no console output.
> > I have not tried any out-of tree debug code :)
> 
> Perhaps it should just move in-tree?

Yes, perhaps it should :)

Regardless, I will try to give it a spin and report back.
