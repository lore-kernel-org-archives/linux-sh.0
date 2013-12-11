From: David Miller <davem@davemloft.net>
Date: Wed, 11 Dec 2013 22:10:05 +0000
Subject: Re: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <20131211.171005.1026686921972557583.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <52A8D90F.9090002@cogentembedded.com>
	<20131211.161146.379334754489134708.davem@davemloft.net>
	<52A8EEF8.3090503@cogentembedded.com>
In-Reply-To: <52A8EEF8.3090503@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 12 Dec 2013 02:02:16 +0300

>    Well, the R8A7791 Ether platform support should appear only in 3.14,
>    so don't bother. I just wanted to understand the principle you
>    follow...

Generally speaking, if the change to support a new device is simply
a matter of adding a new device ID I tend to queue it up for 'net'.
