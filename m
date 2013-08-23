From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Aug 2013 00:12:12 +0000
Subject: Re: [PATCH v6 0/3] R8A7778/BOCK-W R-Car VIN driver support
Message-Id: <20130823001212.GE9254@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201308230134.26092.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308230134.26092.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Aug 23, 2013 at 01:34:25AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Mauro's 'media_tree.git' repo's
> 'master' branch. Here we add the VIN platform code working on
> the R8A7778/BOCK-W with ML86V7667 video decoder.
> 
> [1/3] ARM: shmobile: r8a7778: add VIN support
> [2/3] ARM: shmobile: BOCK-W: add VIN and ML86V7667 support
> [3/3] ARM: shmobile: BOCK-W: enable VIN and ML86V7667 in defconfig
> 
>    Mauro has kindly agreed to merge this patchset thru his tree to resolve the
> dependency on the driver's platform data header, provided that the maintainer
> ACKs this. Simon, could you ACK the patchset ASAP -- Mauro expects to close his
> tree for 3.12 this weekend or next Monday?

Sure, all three patches:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
