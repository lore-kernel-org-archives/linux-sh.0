From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Dec 2015 05:32:21 +0000
Subject: Re: [PATCH 1/2] sh_eth: remove EDMAC_BIG_ENDIAN
Message-Id: <20151228053220.GG1066@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <27915743.MLN0FvErP3@wasted.cogentembedded.com>
 <1789816.9Rg3E9smcf@wasted.cogentembedded.com>
In-Reply-To: <1789816.9Rg3E9smcf@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Dec 28, 2015 at 02:07:08AM +0300, Sergei Shtylyov wrote:
> Commit  71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support") added support
> for the big-endian EDMAC descriptors. However, it was never used and never
> worked right until the recent driver  fixes. I think we now  can just remove
> this support,  it was only burdening the driver from the start. It should be
> easy to do without disturbing the SH platform code, at least for now...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

