From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 27 Jan 2015 19:06:57 +0000
Subject: Re: [PATCH 0/2] sh_eth: massage PM code
Message-Id: <54C7E1D1.9050707@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5608250.lrFkJTjgSf@wasted.cogentembedded.com>
In-Reply-To: <5608250.lrFkJTjgSf@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, David Miller <davem@davemloft.net>
Cc: linux-sh@vger.kernel.org

Hello.

On 01/22/2015 01:16 AM, Sergei Shtylyov wrote:

>     Here's a set of 2 patches against DaveM's 'net-next.git' repo. We're adding
> the support for suspend/hibernation as well as somewhat changing the existing
> code. There are still MDIO-related issue with suspend (kernel exception), we've
> been working on it and shall address it with a separate patch...

    It turned out that Florian Fainelli's recent series was the best approach 
to fixing this issue. We were only looking at our driver while it was a common 
MDIO problem...

> [1/2] sh_eth: use SET_RUNTIME_PM_OPS()
> [2/2] sh_eth: add more PM methods

WBR, Sergei

