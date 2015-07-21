From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jul 2015 03:42:21 +0000
Subject: Re: [PATCH] ravb: fix race updating TCCR
Message-Id: <20150720.204221.665725597328229621.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <6587398.M5V25fvqHl@wasted.cogentembedded.com>
In-Reply-To: <6587398.M5V25fvqHl@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 17 Jul 2015 00:28:38 +0300

> The TCCR.TSRQn bit may get clearead after TCCR gets read, so that TCCR write
> would get skipped. We don't need to check this bit before setting.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
