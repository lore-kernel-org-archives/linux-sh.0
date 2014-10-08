From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 Oct 2014 21:45:14 +0000
Subject: Re: [PATCH] renesas_usbhs: fix platform init error message
Message-Id: <5435B06A.8020705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1629718.KlA1FP4xFz@wasted.cogentembedded.com>
In-Reply-To: <1629718.KlA1FP4xFz@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/09/2014 01:42 AM, Sergei Shtylyov wrote:

> There is a typo ("prove" instead of "probe") in the error message printed when
> the platform initialization fails. Replace that word with more fitting "init".

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

    Oops, forgot to mention the patch is atop of the 'usb-linus' branch of 
GregKH's repo.

WBR, Sergei

