From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jan 2008 00:46:35 +0000
Subject: Re: [PATCH] sh: add resource of USB for SH7720
Message-Id: <20080122004635.GB26756@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <47860ABA.7000407@renesas.com>
In-Reply-To: <47860ABA.7000407@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 21, 2008 at 03:40:10PM +0100, Kristoffer Ericson wrote:
> Anyone willing to give a quick explanation for usb-newbie :)
> 
What Manuel said was already pretty self-explanatory, if you don't
understand the problem, you will probably want to wait until SH7760 OHCI
drivers have been written and merged, and then see about writing an
HD64465 driver modelled on top of that.

In summary, patches are in progress that should finally let us handle
SH7760 OHCI (and the other crippled OHCI implementations), SM501 is just
where most of that has been prototyped.

Finally, do not top post, ever.
