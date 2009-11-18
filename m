From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Nov 2009 01:52:05 +0000
Subject: Re: [patch 05/13] sh: Fixup last users of irq_chip->typename
Message-Id: <20091118015205.GB3414@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091117224852.846805939@linutronix.de> <20091117224916.528768738@linutronix.de>
In-Reply-To: <20091117224916.528768738@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-sh@vger.kernel.org

On Tue, Nov 17, 2009 at 10:50:45PM -0000, Thomas Gleixner wrote:
> The typename member of struct irq_chip was kept for migration purposes
> and is obsolete since more than 2 years. Fix up the leftovers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org

Applied, thanks.
