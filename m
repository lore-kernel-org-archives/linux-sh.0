From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 17 Jan 2008 01:26:03 +0000
Subject: Re: Question regarding arch/sh/cchips merger
Message-Id: <20080117012603.GC14107@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080116224540.2e2ae7e6.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20080116224540.2e2ae7e6.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 16, 2008 at 10:45:40PM -0800, Kristoffer Ericson wrote:
> Would it be good to merge hd64465/hd64461 inside arch/sh/cchips? Ive
> checked the files and they are quite similiar and since the header can
> be merged they could also be easily. You mentioned the they really
> belong inside mfd but never touched that area.
> 
> So in short, would such a patch be accepted?
> 
Merging in arch/sh/cchips is fine for now, but it really does need to be
cleaned up to look more like a standard mfd driver, and moved in to
drivers/mfd proper. Following something like sm501 as an example of how
to do things like the IRQ demux sanely.

While I can give you suggestions on what needs to be done, I don't have
anything with those ancient cchips on it either at the office or at home,
which makes you the sole person to do the mfd work. At this point hp6xx
is the only thing using these parts, so presumably you have some sort of
testing in place that ensures that things are happy on the cchip side.
