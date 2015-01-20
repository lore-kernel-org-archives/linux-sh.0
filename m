From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 20 Jan 2015 19:41:44 +0000
Subject: Re: [PATCH 2/2] shdmac: extend PM methods
Message-Id: <54BEAF78.8060906@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7124495.gOhk31Ctg5@wasted.cogentembedded.com>
In-Reply-To: <7124495.gOhk31Ctg5@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 01/20/2015 02:07 AM, Sergei Shtylyov wrote:

> In order to make it possible to restore from hibernation not only in Linux but
> also in e.g. U-Boot, we have to use sh_dmae_{suspend|resume}() for the {freeze|
> thaw|restore}() PM methods. It's handy to achieve this with SIMPLE_DEV_PM_OPS()
> macro; since  that macro doesn't do anything when CONFIG_PM_SLEEP  is undefined,
> we don't need to #define sh_dmae_{suspend|resume} NULL anymore; it seems safe to
> leave the #ifdef CONFIG_PM alone  as this option  is selected by CONFIG_PM_SLEEP
> anyway...

    However, when CONFIG_PM is defined and CONFIG_PM_SLEEP is not, we'll still 
get the function unused warnings... so I'm going to recast this patch 
(actually, my first variant was correct).

> Based on orignal patch by Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei

