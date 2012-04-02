From: Simon Horman <horms@verge.net.au>
Date: Mon, 02 Apr 2012 05:03:52 +0000
Subject: Re: [PATCH] Input: st1232 - switch to using SIMPLE_DEV_PM_OPS
Message-Id: <20120402050352.GB20454@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20120331061801.GA20441@core.coreip.homeip.net>
 <20120401232808.GA2336@verge.net.au>
 <b9a9f8b3-9b97-47f2-a845-76b4613ec6ca@email.android.com>
In-Reply-To: <b9a9f8b3-9b97-47f2-a845-76b4613ec6ca@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Apr 01, 2012 at 05:41:40PM -0700, Dmitry Torokhov wrote:
> 
> 
> Hi Simon,
> 
> Simon Horman <horms@verge.net.au> wrote:
> 
> >Hi,
> >
> >I'm not sure that I follow why st1232_ts_pm_ops is needed
> >if CONFIG_PM_SLEEP isn't defined.
> >
> 
> In case of !CONFIG_PM_SLEEP dev_pm_ops is an empty structure; having it allows us to drop some ifdefs.

Thanks, understood.

Reviewed-by: Simon Horman <horms@verge.net.au>

