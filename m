From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Feb 2010 02:32:57 +0000
Subject: Re: [PATCH] usb: r8a66597-hdc disable interrupts fix
Message-Id: <20100202023257.GE13428@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100127074119.25763.59310.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100127074119.25763.59310.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 29, 2010 at 12:08:13PM +0900, Yoshihiro Shimoda wrote:
> Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > This patch improves disable_controller() in the r8a66597-hdc
> > driver to disable all interrupts and clear status flags. It
> > also makes sure that disable_controller() is called during
> > probe(). This fixes the relatively rare case of unexpected
> > pending interrupts after kexec reboot.
> 
> Thank you very much for your patch.
> 
> Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> 
Queued for 2.6.33, thanks.
