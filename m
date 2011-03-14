From: Stephen Boyd <sboyd@codeaurora.org>
Date: Mon, 14 Mar 2011 09:06:36 +0000
Subject: Re: [PATCH 10/10] ARM: Use struct syscore_ops instead of sysdevs
Message-Id: <4D7DDA9C.9020700@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl> <201103131402.48129.rjw@sisk.pl> <201103131404.33311.rjw@sisk.pl>
In-Reply-To: <201103131404.33311.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

On 3/13/2011 6:04 AM, Rafael J. Wysocki wrote:
>   #if defined(CONFIG_PM)&&  !defined(CONFIG_GENERIC_CLOCKEVENTS)
> -static int timer_suspend(struct sys_device *dev, pm_message_t state)
> +static int timer_suspend(void)
>   {
> -	struct sys_timer *timer = container_of(dev, struct sys_timer, dev);
> -
> -	if (timer->suspend != NULL)
> +	if (system_timer->suspend)
>   		timer->suspend();
>

Shouldn't this be system_timer->suspend() ?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

