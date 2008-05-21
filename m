From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Wed, 21 May 2008 11:58:24 +0000
Subject: Re: [PATCH 01/03] uio: Add enable_irq() callback
Message-Id: <aec7e5c30805210458m3d15b89am563e4a94b8eb6f2c@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se>
	 <20080520105140.1474.59715.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080520105140.1474.59715.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, hjk@linutronix.de, gregkh@suse.de, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>

On Tue, May 20, 2008 at 7:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Add enable_irq() callback to struct uio_info. This callback is needed by
> the uio_platform driver so interrupts can be enabled before blocking.

We can most likely use a single uio platform driver if this patch is
acceptable. Any NAKs?

Thanks,

/ magnus
