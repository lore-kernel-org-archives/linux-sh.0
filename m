From: David Miller <davem@davemloft.net>
Date: Tue, 14 Jul 2015 22:37:47 +0000
Subject: Re: [PATCH] ravb: kill useless initializers
Message-Id: <20150714.153747.1713328371232217300.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <3087282.SVZhuJYtXK@wasted.cogentembedded.com>
In-Reply-To: <3087282.SVZhuJYtXK@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 10 Jul 2015 21:10:10 +0300

> Some of the local variable intializers in the driver turned out to be pointless,
> kill them.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
