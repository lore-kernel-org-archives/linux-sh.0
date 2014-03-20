From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 20 Mar 2014 17:44:13 +0000
Subject: Re: [PATCH] micrel: fix masking off LED bits
Message-Id: <532B36F5.20605@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403190258.16812.sergei.shtylyov@cogentembedded.com> <20140319.174205.1425627653050633421.davem@davemloft.net>
In-Reply-To: <20140319.174205.1425627653050633421.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, ben.dooks@codethink.co.uk

Hello.

On 03/20/2014 12:42 AM, David Miller wrote:

>> Commit 20d8435a1cff (phy: micrel: add of configuration for LED mode) made the
>> obvious mistake when masking off  the LED mode bits: forgot to do a logical NOT
>> to the mask with which it ANDs the register value, so that unrelated bits are
>> cleared instead.

    I'm seeing now that I hadn't finished editing the changelog before 
submitting -- the verbs have inconsistent times. So much for my haste... :-)

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Applied to net-next, thanks.

    Thanks.

WBR, Sergei

