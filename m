From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Dec 2015 00:42:21 +0000
Subject: Re: [PATCH 1/3] sh_eth: remove mask fields from 'struct bb_info'
Message-Id: <20151208004221.GH10799@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1582774.FcjyuztLtc@wasted.cogentembedded.com>
 <8193175.UjRYeBy7vc@wasted.cogentembedded.com>
In-Reply-To: <8193175.UjRYeBy7vc@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Dec 08, 2015 at 12:40:19AM +0300, Sergei Shtylyov wrote:
> The MDIO control bits are always mapped to the same bits of the same register
> (PIR), so there's no need to store their masks in the 'struct bb_info'...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
