From: "Hans J. Koch" <hjk@linutronix.de>
Date: Thu, 22 May 2008 20:18:29 +0000
Subject: Re: [PATCH 01/03] uio: Add enable_irq() callback
Message-Id: <20080522201829.GE3226@local>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se> <20080520105140.1474.59715.sendpatchset@rx1.opensource.se> <aec7e5c30805210458m3d15b89am563e4a94b8eb6f2c@mail.gmail.com>
In-Reply-To: <aec7e5c30805210458m3d15b89am563e4a94b8eb6f2c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, hjk@linutronix.de, gregkh@suse.de, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>

On Wed, May 21, 2008 at 08:58:24PM +0900, Magnus Damm wrote:
> On Tue, May 20, 2008 at 7:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > Add enable_irq() callback to struct uio_info. This callback is needed by
> > the uio_platform driver so interrupts can be enabled before blocking.
> 
> We can most likely use a single uio platform driver if this patch is
> acceptable. Any NAKs?

Yes. Your approach only allows enabling interrupts, but not disabling
them. And I don't like that it is not possible for generic userspace
tools to find out if a UIO device has this auto-irq-enabling capability
or not.

I just posted a patch that allows enabling _and_ disabling of irqs from
userspace by writing 0 or 1 to /dev/uioX. I've CCed you, could you
please test? If this doesn't do what you need, please let me know.

Thanks,
Hans

