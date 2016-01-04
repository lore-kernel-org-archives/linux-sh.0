From: David Miller <davem@davemloft.net>
Date: Mon, 04 Jan 2016 21:11:28 +0000
Subject: Re: [PATCH 0/2] sh_eth: remove unused BE descriptor support
Message-Id: <20160104.161128.2202956416981407539.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <27915743.MLN0FvErP3@wasted.cogentembedded.com>
In-Reply-To: <27915743.MLN0FvErP3@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 28 Dec 2015 02:05:24 +0300

>    Here's a set of 2 patches against DaveM's 'net-next.git' repo plus the
> recently merged to 'net.git' repo fix for the 16-bit descriptor endianness.
> We get rid of ~30 LoCs and ~300 bytes of code.

Series applied, thanks Sergei.
