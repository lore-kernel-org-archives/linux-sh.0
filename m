From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Mar 2014 18:35:39 +0000
Subject: Re: [PATCH] micrel: fix masking off LED bits
Message-Id: <5329F182.6090206@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403190258.16812.sergei.shtylyov@cogentembedded.com> <53295171.3020700@codethink.co.uk> <CAGVrzcZd6rx0dbAdtqk3pbjuTVr4vwFqsRJxgc+dTQ0imnY57Q@mail.gmail.com>
In-Reply-To: <CAGVrzcZd6rx0dbAdtqk3pbjuTVr4vwFqsRJxgc+dTQ0imnY57Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Fainelli <f.fainelli@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>
Cc: netdev <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

On 03/19/2014 07:21 PM, Florian Fainelli wrote:

>>> Commit 20d8435a1cff (phy: micrel: add of configuration for LED mode) made
>>> the
>>> obvious mistake when masking off  the LED mode bits: forgot to do a
>>> logical NOT
>>> to the mask with which it ANDs the register value, so that unrelated bits
>>> are
>>> cleared instead.

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> Acked-by: Ben Dooks <ben.dooks@codethink.co.uk>

> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

    Oh, sorry for not CCing you -- I forgot that phylib is now maintained.

WBR, Sergei

