From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 17 Jun 2013 10:31:39 +0000
Subject: Re: [PATCH v4 0/5] Renesas TPU PWM support
Message-Id: <1401873.dJyJ3o5vr2@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371142488-2514-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 17 June 2013 13:25:49 Simon Horman wrote:
> Hi Laurent,
> 
> I am having a little trouble testing this.
> I am wondering if you could guide me as to
> what .config options I should have enabled and
> what values I should be looking for in /sys ?

Sure. You need to enable CONFIG_LEDS_PWM and CONFIG_PWM_RENESAS_TPU). You 
should then be able to control the LEDs through /sys/class/leds/*.

-- 
Regards,

Laurent Pinchart

