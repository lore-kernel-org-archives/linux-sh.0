From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 Jul 2008 01:13:25 +0000
Subject: Re: [patch] kdump: sh: parse elfcorehdr command line argument
Message-Id: <20080730011325.GA7529@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080730002937.GA21998@verge.net.au>
In-Reply-To: <20080730002937.GA21998@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-sh@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Wed, Jul 30, 2008 at 10:29:39AM +1000, Simon Horman wrote:
> A quick cut and paste from other architectures to allow SH
> to parse the elfcorehdr command line argument which is required
> for both is_kdump_kernel() and vmcore to function.
> (the former is as yet unused on SH).
> 
> Tested compilation only
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
This was the first thing I was going to do this morning, but you beat me
to it. :-)

Applied, thanks!
