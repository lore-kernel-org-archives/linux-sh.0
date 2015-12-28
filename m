From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Dec 2015 05:32:29 +0000
Subject: Re: [PATCH 2/2] sh_eth: get rid of {cpu|edmac}_to_{edmac|cpu}()
Message-Id: <20151228053229.GH1066@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <27915743.MLN0FvErP3@wasted.cogentembedded.com>
 <7645144.Pie2WFS3t2@wasted.cogentembedded.com>
In-Reply-To: <7645144.Pie2WFS3t2@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Dec 28, 2015 at 02:10:47AM +0300, Sergei Shtylyov wrote:
> Now that {cpu|edmac}_to_{edmac|cpu}() functions boiled down to the mere
> {cpu|le32}_to_{le32|cpu}() calls, there's no need for these functions
> anymore, so just get rid of them.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

