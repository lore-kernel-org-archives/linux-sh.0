From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Apr 2013 16:28:19 +0000
Subject: Re: [PATCH 4/8] rcar-phy: remove EHCI internal buffer setup
Message-Id: <515EFBA3.7040702@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304050303.56515.sergei.shtylyov@cogentembedded.com>
 <20130405004300.GO29203@verge.net.au>
In-Reply-To: <20130405004300.GO29203@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 05-04-2013 4:43, Simon Horman wrote:

>> Now that the EHCI internal buffer setup is done by the platform code, we  can
>> remove  such code from this driver as it never really belonged here.  We also
>> no longer need the 2nd memory region now (2nd EHCI controller is simply missing
>> in e.g. R8A7778 SoC).

> I wonder if this patch could be split into a driver patch
> followed by an SoC patch. Or vice versa.

    This one indeed can, I just tried to somewhat save on patches. But not 
vice versa, of course, that'll break bisection. :-)

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei

