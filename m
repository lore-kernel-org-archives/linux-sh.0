From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Dec 2015 00:42:37 +0000
Subject: Re: [PATCH 3/3] sh_eth: get rid of bb_{set|clr|read}()
Message-Id: <20151208004236.GJ10799@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1582774.FcjyuztLtc@wasted.cogentembedded.com>
 <2620242.OINoAeziLK@wasted.cogentembedded.com>
In-Reply-To: <2620242.OINoAeziLK@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Dec 08, 2015 at 12:41:43AM +0300, Sergei Shtylyov wrote:
> After the MDIO bitbang code consolidation, there's no need anymore for
> bb_{set|clr}() as well as bb_read() -- just expand them inline, thus
> saving more LoCs...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

