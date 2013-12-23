From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 23 Dec 2013 17:57:57 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: Lager: conditionally select CONFIG_MICREL_PHY
Message-Id: <52B887B2.7070507@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
 <201312200220.54747.sergei.shtylyov@cogentembedded.com>
 <20131223005322.GJ12239@verge.net.au>
In-Reply-To: <20131223005322.GJ12239@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 12/23/2013 03:53 AM, Simon Horman wrote:

>> Now that support for KSZ8041RNLI is added to the Micrel PHY driver and we intend
>> to support PHY IRQs on the Lager board, we have to enable the Micrel driver.
>> Do this by selecting CONFIG_MICREL_PHY for Lager if CONFIG_SH_ETH is enabled.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Hi Sergei,

> while I am very happy to see this change unfortunately it no longer
> applies. Could you please rebase it on top of
> renesas-devel-v3.13-rc4-20131219?

    Hmm, it *was done* on top of this tag. Perhaps you meant today's 
renesas-devel-v3.13-rc5-20131223?

> Thanks

WBR, Sergei

