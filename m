From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 29 Jan 2010 03:08:13 +0000
Subject: Re: [PATCH] usb: r8a66597-hdc disable interrupts fix
Message-Id: <4B62511D.6010302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100127074119.25763.59310.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100127074119.25763.59310.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch improves disable_controller() in the r8a66597-hdc
> driver to disable all interrupts and clear status flags. It
> also makes sure that disable_controller() is called during
> probe(). This fixes the relatively rare case of unexpected
> pending interrupts after kexec reboot.

Thank you very much for your patch.

Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Thanks,
Yoshihiro Shimoda
