From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 11 Dec 2013 15:39:05 +0000
Subject: Re: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <52A88719.4000406@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312100220.42153.sergei.shtylyov@cogentembedded.com> <20131210.222639.2106376982664488750.davem@davemloft.net>
In-Reply-To: <20131210.222639.2106376982664488750.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 11-12-2013 7:26, David Miller wrote:

>> Renesas R-Car development boards use KSZ8041RNLI PHY which for some reason has
>> ID of 0x00221537 that is not documented for KSZ8041-family PHYs and does not
>> match the  documented ID of  0x0022151x (where 'x' is the revision).  We have
>> to add the new #define PHY_ID_* and new ksphy_driver[] entry, almost the same
>> as KSZ8041 one, differing only in the 'phy_id' and 'name' fields.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> This patch is atop of DaveM's 'net-next.git' repo.

> You said something to Geert about "Though it's not the last version
> probably..." are you talking about this patch needing more revisions?

    Well, maybe. I half-expected some criticisms. My changelog was somewhat 
tautological, and I'm not sure about the ID mask, perhaps it should be 
0x00ffffff to also cover the revision field. Since the ID is totally 
undocumented, I'm just not very sure how to deal with it properly.

> If so, please make it explicit that you are posting something that is
> just for feedback and not applying by using "RFC" in the subject line.

    At the time of sending I intended it to be applied, if no negative 
comments would have been posted.

> Thanks.

WBR, Sergei

