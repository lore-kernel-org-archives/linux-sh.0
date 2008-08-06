From: Alessandro Zummo <alessandro.zummo@towertech.it>
Date: Wed, 06 Aug 2008 18:01:43 +0000
Subject: Re: [PATCH 1/2] rtc: rtc-rs5c372: SMBus conversion/support
Message-Id: <20080806200143.1edf2775@i1501.lan.towertech.it>
List-Id: <linux-sh.vger.kernel.org>
References: <20080806105942.GB5354@linux-sh.org>
In-Reply-To: <20080806105942.GB5354@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 6 Aug 2008 19:59:42 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> The special case is iop3xx, which has more than its fair share of hacks
> within this driver, it remains untested -- though also claims to support
> emulated SMBus accesses. The corner case there is rs5c_get_regs() which
> uses access mode #3 for transferring the register state, while we use
> mode #1 for SMBus.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> Acked-by: David Brownell <david-b@pacbell.net>
> Tested-by: Riku Voipio <riku.voipio@movial.fi>

Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

