From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 02:49:37 +0000
Subject: Re: [PATCH 0/2] drivers: sh: clk: Cleanup clock API
Message-Id: <20151124024936.GG21853@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447957927-32738-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-clk@vger.kernel.org

On Thu, Nov 19, 2015 at 07:32:05PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series cleans up the clock API on legacy SH, to make it more
> similar with the Common Clock Framework.  This will avoid different
> behavior in drivers shared between legacy and CCF-based platforms (e.g.
> SCIF).
> 
> Thanks for applying!

Thanks, done.
