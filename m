From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 13 May 2010 13:20:32 +0000
Subject: Re: + mmc-add-dma-support-to-tmio_mmc-driver-when-used-on-superh.patch
Message-Id: <Pine.LNX.4.64.1005131511540.4671@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201005122255.o4CMtmvN025653@imap1.linux-foundation.org>
 <AANLkTim5U-JbrVCBKHnERgHol2GcwTfweQyI4onR1Skh@mail.gmail.com>
 <Pine.LNX.4.64.1005131357500.4671@axis700.grange>
 <AANLkTinPW2W6aV1smLsQObLOAS3bECDZ7mhSGCm2aqgO@mail.gmail.com>
 <Pine.LNX.4.64.1005131415460.4671@axis700.grange>
 <AANLkTik4gzuZvrAwbK-dyCXVYf5gLD0RGrpvM55YLzOK@mail.gmail.com>
In-Reply-To: <AANLkTik4gzuZvrAwbK-dyCXVYf5gLD0RGrpvM55YLzOK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

(re-adding CC)

On Thu, 13 May 2010, Ian Molton wrote:

> Might be worth exposing for now, whilst the feature is new. but yes,
> automatic select yes on all the platforms you are comfortable with.
> 
> Im not sure if it should be per MFD or per platform. I tend to think
> the latter, given that its slave DMA and thus I could have the same
> MFD in platforms with different CPUs (eg. e740 and e800) where a CPU
> bug might upset one but not the other.

So far I went for the least effort - not exposed, selected by MFDs. If we 
ever have a need to change this, e.g., make it user-selectable or per 
platform, we can always do so later. For now all SuperH / SH-Mobile 
platforms I tested can use this driver with DMA. Expect updated patches 
shortly.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
