From: Mikhail Ulianov <mikhail.ulyanov@cogentembedded.com>
Date: Wed, 06 May 2015 05:46:49 +0000
Subject: Re: [PATCH v3 1/1] V4L2: platform: Renesas R-Car JPEG codec driver
Message-Id: <20150506084649.3bc76d27@bones>
List-Id: <linux-sh.vger.kernel.org>
References: <1430344409-11928-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
	<5004544.CpPfGJfHMn@avalon>
In-Reply-To: <5004544.CpPfGJfHMn@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: hverkuil@xs4all.nl, horms@verge.net.au, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, linux-media@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, 04 May 2015 02:32:05 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
> 
> Thank you for the patch. Please see below for a (partial) review.
> 
> On Thursday 30 April 2015 00:53:29 Mikhail Ulyanov wrote:
> > Here's the the driver for the Renesas R-Car JPEG processing unit
> > driver.
> > 
> > The driver is implemented within the V4L2 framework as a mem-to-mem
> > device. It presents two video nodes to userspace, one for the
> > encoding part, and one for the decoding part.
> > 
> > It was found that the only working mode for encoding is no markers
> > output, so we generate it with software. In current version of
> > driver we also use software JPEG header parsing because with
> > hardware parsing performance is lower then desired.
> 
> Just out of curiosity, what is the performance impact of hardware
> parsing ?
Looks like feature of IP core. Header parsing complete/continue
sequence make it work 1.5-2 times longer, so as i remember maximum
performance with 1Mp YUV420 JPEG decoding was ~60 FPS. 
