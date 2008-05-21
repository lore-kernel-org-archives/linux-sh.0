From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 21 May 2008 07:49:50 +0000
Subject: Re: [PATCH 00/03][RFC] Reusable UIO Platform Driver
Message-Id: <20080521074950.GA27310@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se> <20080520210713.GE3220@local> <aec7e5c30805202031x62b3b463lfde0b9e7eb32d35@mail.gmail.com> <20080521064938.GA11580@digi.com>
In-Reply-To: <20080521064938.GA11580@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Uwe Kleine-K?nig <Uwe.Kleine-Koenig@digi.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Hans J. Koch" <hjk@linutronix.de>, linux-kernel@vger.kernel.org, gregkh@suse.de, linux-sh@vger.kernel.org

On Wed, May 21, 2008 at 08:49:38AM +0200, Uwe Kleine-K?nig wrote:
> Magnus Damm wrote:
> >         Extending uio_pdrv driver with a chunk of physically
> > contiguous memory isn't a big deal though.
> I wonder how you use that memory.  Isn't it just some kind of shared
> memory?  If so, why not use normal shared memory?  Do you really need
> that?
> 
Physically contiguous memory is a real requirement, especially for DMA.
I'm not sure what's confusing about that?
