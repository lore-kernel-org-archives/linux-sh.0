From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jan 2012 02:44:58 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add GPIO-to-IRQ translation to sh7372
Message-Id: <20120124024458.GA26028@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201231549470.11184@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201231549470.11184@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 23, 2012 at 03:52:03PM +0100, Guennadi Liakhovetski wrote:
> This table is required to support the gpio_to_irq() translation.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Please, review. I don't think I can say much about the correctness of this 
> patch apart from, that it works for my specific case:-)
> 
I've applied it as-is. If it works for your case, that's better than not
working at all, and if it's broken for others, it can be fixed up by
someone who cares at a later point in time.
