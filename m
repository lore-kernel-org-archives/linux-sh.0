From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 04 Feb 2010 09:24:04 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd: Fix up spinlock recursion in root hub
Message-Id: <4B6A9234.3010206@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100204065828.GB5574@linux-sh.org>
In-Reply-To: <20100204065828.GB5574@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> The current root hub polling code exhibits a spinlock recursion on the
> private controller lock. r8a66597_root_hub_control() is called from
> r8a66597_timer() which grabs the lock and disables IRQs. The following
> chain emerges:
> 
>   r8a66597_timer() <-- lock taken
>     r8a66597_root_hub_control()
>       r8a66597_check_syssts()
>         usb_hcd_poll_rh_status() <-- acquires the same lock
> 	/* insert death here */
> 
> The entire chain requires IRQs to be disabled, so we just unlock and
> relock around the call to usb_hcd_poll_rh_status() while leaving the
> IRQ state unchanged.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Thank you very much again!
Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Thanks,
Yoshihiro Shimoda

