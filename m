From: Simon Horman <horms@verge.net.au>
Date: Tue, 06 Oct 2015 00:45:02 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: add Ether DT support
Message-Id: <20151006004502.GC12506@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1507520.6rxyDiKYNB@wasted.cogentembedded.com>
In-Reply-To: <1507520.6rxyDiKYNB@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 06, 2015 at 01:51:01AM +0300, Sergei Shtylyov wrote:
> Define  the Porter board dependent part of  the Ether device node.
> Enable DHCP and NFS root for the kernel booting.
> 
> This  patch  is analogous to the commit 26b0d2cf73cb (ARM: shmobile: henninger:
> add Ether DT support)  as there  are no differences between those boards in this
> respect.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---

Thanks, I have queued this up.
