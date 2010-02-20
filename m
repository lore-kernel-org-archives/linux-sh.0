From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 20 Feb 2010 12:17:14 +0000
Subject: Re: Unaligned kernel access for __udivsi3_i4i
Message-Id: <20100220121713.GA27558@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
In-Reply-To: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Feb 20, 2010 at 11:47:16AM +0000, Matt Fleming wrote:
> On Sat, Feb 20, 2010 at 01:24:38AM +0100, Drasko DRASKOVIC wrote:
> > Does that mean that we can do division by zero that goes completely
> > unnoticed, unless we turn up the warnings (as kernel will fix these
> > unalignments without even reporting it)?
> 
> Unfortunately, yes.
> 
There are two sides to consider. Division by zero is generally an FPU
exception and you can instrument the FPU error exception handlers
accordingly for the cases where userspace is responsible. For the
__udivsi3_i4i case this will just result in an address error being raised
given that it's wholly integer based. The regular __udivsi3_i4 case on
the other hand will have a different exception path due to being FPU
bounded, assuming you haven't disabled FPU code for your userspace
applications.
