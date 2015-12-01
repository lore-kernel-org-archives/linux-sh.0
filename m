From: Simon Horman <horms@verge.net.au>
Date: Tue, 01 Dec 2015 07:44:50 +0000
Subject: Re: [PATCH v2] ravb: add R8A7791 support
Message-Id: <20151201074450.GA31496@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1661514.u50jDu7LON@wasted.cogentembedded.com>
In-Reply-To: <1661514.u50jDu7LON@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org

On Tue, Dec 01, 2015 at 01:01:18AM +0300, Sergei Shtylyov wrote:
> Add support  for yet another ARM member of the R-Car family, R-Car M2-W,
> also known as R8A7791.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against DaveM's 'net-next.git' repo but I wouldn't mind if it's
> applied to 'net.git' instead. :-)
> 
> Changes in version 2:
> - fixed the SoC name in the changelog.

I have no particular problem with this patch but as mentioned elsewhere I
have been working on a more comprehensive patchset which I have now posted as:

"[PATCH 0/2 net-next] ravb: More compat strings"
