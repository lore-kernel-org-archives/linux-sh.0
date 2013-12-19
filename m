From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 19 Dec 2013 21:43:30 +0000
Subject: Re: [PATCH 0/2] Add PHY IRQ support to the 'sh_eth' driver
Message-Id: <52B37684.5030206@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200138.09307.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312200138.09307.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

On 12/20/2013 01:38 AM, Sergei Shtylyov wrote:

>     This patchset adds support for passing PHY's IRQ to the 'sh_eth' driver from
> the platform code and removes now useless code that hinders the PHY IRQ handing
> by philib.

    Ugh, forgot to mention it's against DaveM's 'net-next.git' repo.

> [1/2] sh_eth: add PHY IRQ to platform data
> [2/2] sh_eth: do not reset PHY needlessly

WBR, Sergei

