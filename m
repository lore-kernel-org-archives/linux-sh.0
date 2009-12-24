From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Dec 2009 10:12:43 +0000
Subject: Re: Probably cache synchronization issue on SH7723
Message-Id: <20091224101243.GA31200@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 24, 2009 at 10:50:31AM +0100, Pietrek, Markus wrote:
> > If we can't find the cause of this bug soon I imagine that Paul will
> > queue up some band-aid patch so that, whilst there will be a
> > performance loss, at least things will work correctly ;-)
> 
> The loss might not be as big as having to use the cache in write-through mode ;-)
> 
I pushed out a reworked version of your patch, so give current git a try
and see if that fixes up your remaining issues. These changes will be
reflected in 2.6.33-rc2.
