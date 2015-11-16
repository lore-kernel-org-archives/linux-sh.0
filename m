From: David Miller <davem@davemloft.net>
Date: Mon, 16 Nov 2015 19:44:55 +0000
Subject: Re: [PATCH net] ravb: Fix int mask value overwritten issue
Message-Id: <20151116.144455.482805305323360767.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1447410289-3741-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1447410289-3741-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ykaneko0929@gmail.com
Cc: netdev@vger.kernel.org, horms@verge.net.au, magnus.damm@gmail.com, linux-sh@vger.kernel.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 13 Nov 2015 19:24:49 +0900

> From: Masaru Nagai <masaru.nagai.vx@renesas.com>
> 
> When RX/TX interrupt for Network Control queue and Best Effort queue
> is issued at the same time, the interrupt mask of Network Control
> queue will be reset when the mask of Best Effort queue is set.
> This patch fixes this problem.
> 
> Signed-off-by: Masaru Nagai <masaru.nagai.vx@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Applied.
