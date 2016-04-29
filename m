From: Rob Landley <rob@landley.net>
Date: Fri, 29 Apr 2016 04:57:35 +0000
Subject: Re: Removing SH-5 support
Message-Id: <5722E9BF.6080804@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20160428203705.GA29613@brightrain.aerifal.cx>
In-Reply-To: <20160428203705.GA29613@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/28/2016 03:37 PM, Rich Felker wrote:
> GCC's sh target maintainers have finally removed support for SH-5 from
> trunk:
> 
> https://gcc.gnu.org/viewcvs/gcc?limit_changes=0&view=revision&revision#5544
> 
> It's probably been broken for a long time, and the associated clutter
> was hindering development progress on SH-2/3/4 targets which are
> actually supported.
> 
> In light of this change, which leaves us with no future toolchain
> support for SH-5, and the lack of any interest in SH-5 from users or
> developers, I'd like to remove SH-5 support from the kernel too. This
> should streamline the existing code and make it easier to modernize
> the arch/sh tree.
> 
> Any objections?

SH5 attempted to introduce a new instruction set, which never took off.
It is to conventional superh what itanium is to x86.

Rob
