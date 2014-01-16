From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 16 Jan 2014 15:19:46 +0000
Subject: Re: [PATCH v6 net-next 1/4] sh_eth: Use bool as return type of sh_eth_is_gether()
Message-Id: <52D7F892.1050708@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389839656-10932-1-git-send-email-horms+renesas@verge.net.au>
 <1389839656-10932-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389839656-10932-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 16-01-2014 6:34, Simon Horman wrote:

> Return a boolean and use true and false.

    You're not using them explicitly anymore. I'd update the changelog
with converting the function to one-liner.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

WBR, Sergei

