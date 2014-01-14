From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 14 Jan 2014 22:49:19 +0000
Subject: Re: [PATCH] irq-gic: remove file name from heading comment
Message-Id: <52D5CCFB.1090205@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312140224.53928.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 12/14/2013 02:24 AM, Sergei Shtylyov wrote:

> File names in the heading comments  fell out of favor long ago, and this one
> weren't even changed when the driver was moved from arch/arm/common/, so remove
> it at last...

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is against the 'irq/core' branch of the 'tip.git' repo.

    Thomas, is there a chance that you merge this patch for 3.14? Is it even 
the right branch for cleanups (I'm seeing fixes there)?

WBR, Sergei

