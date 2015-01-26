From: David Miller <davem@davemloft.net>
Date: Mon, 26 Jan 2015 23:27:15 +0000
Subject: Re: [PATCH 0/2] sh_eth: massage PM code
Message-Id: <20150126.152715.1448055643815693106.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <5608250.lrFkJTjgSf@wasted.cogentembedded.com>
In-Reply-To: <5608250.lrFkJTjgSf@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 22 Jan 2015 01:16:54 +0300

>    Here's a set of 2 patches against DaveM's 'net-next.git' repo. We're adding
> the support for suspend/hibernation as well as somewhat changing the existing
> code. There are still MDIO-related issue with suspend (kernel exception), we've
> been working on it and shall address it with a separate patch...

Series applied, thanks.
