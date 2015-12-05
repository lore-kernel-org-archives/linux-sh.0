From: David Miller <davem@davemloft.net>
Date: Sat, 05 Dec 2015 22:46:55 +0000
Subject: Re: [PATCH] ravb: fix RX queue #1 frame error counter name
Message-Id: <20151205.174655.363763973003627210.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <2605754.h5jel2JHUq@wasted.cogentembedded.com>
In-Reply-To: <2605754.h5jel2JHUq@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 04 Dec 2015 01:51:10 +0300

> The Rx queue #1 frame error counter name contains trailing underscore,
> probably due to a typo...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
