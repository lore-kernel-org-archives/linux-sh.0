From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Mar 2014 23:24:16 +0000
Subject: Re: [PATCH 0/3] Beautify 'sh_eth' driver's messages
Message-Id: <53239DAD.80003@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403150321.47674.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403150321.47674.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

On 03/15/2014 03:21 AM, Sergei Shtylyov wrote:

> This patchset converts te driver to using netdev_*() and netif_*() to print out
> its messages whenever possible.

    Oops, forgot to mention it's against 'net-next.git' repo and the fix I've 
just posted.

> [1/3] sh_eth: convert pr_*() to netdev_*() calls
> [2/3] sh_eth: convert dev_*() to netdev_*() calls
> [3/3] sh_eth: fold netif_msg_*() and dev_*() calls into netif_*() invocations

WBR, Sergei

