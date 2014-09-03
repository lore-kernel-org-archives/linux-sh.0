From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 03 Sep 2014 08:05:46 +0000
Subject: Re: [PATCH v2 00/10] sh73a0 common clock framework implementation
Message-Id: <CAO3366yfU93zTWG1v3MCFfoVQPgPRxdjL1Mw4OnrzDCRc5MyYA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 3, 2014 at 2:09 AM, Simon Horman <horms@verge.net.au> wrote:
> * It looks like some of the "ARM: shmobile:" patches,
>   especially patches 2 - 7, may break bisection. If
>   so could you re-arrange the patches to avoid this?

I don't really see how.

> * It looks like you are enabling CMT1. Thanks for that,
>   for some reason I thought that I had already handled that: it seems not.

Well...

> * Would it be useful if I made a series on top of your series
>   to enable serial via DT. Again, I thought I had already handled
>   that too but it seems I haven't.

...I thought I had handled that already. :) Please go ahead.

CU
Uli
