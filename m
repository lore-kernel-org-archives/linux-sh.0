From: Simon Horman <horms@verge.net.au>
Date: Fri, 23 Oct 2015 00:19:46 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: fix "gpio-ranges" props
Message-Id: <20151023001946.GB15844@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <10037494.4LD4T2QGPX@wasted.cogentembedded.com>
 <14605037.EZjgJcsdsk@wasted.cogentembedded.com>
In-Reply-To: <14605037.EZjgJcsdsk@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 22, 2015 at 02:04:41AM +0300, Sergei Shtylyov wrote:
> On R8A7790, GPIO banks 1 and 2 are missing  pins 30 and 31.  Correct the
> "gpio-ranges" properties of the corresponding device nodes.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20151019-v4.3-rc6' of Simon Horman's
> 'renesas.git' repo.

Thanks, I have queued this up.
