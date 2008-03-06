From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Mar 2008 02:39:41 +0000
Subject: Re: [HP j6xx] - Make APM output some very basic information
Message-Id: <20080306023941.GH31163@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080304230925.4c8eddb0.Kristoffer.Ericson@Gmail.com>
In-Reply-To: <20080304230925.4c8eddb0.Kristoffer.Ericson@Gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 04, 2008 at 11:09:25PM -0800, Kristoffer Ericson wrote:
> This patch fixes the old non-verbose hp6xx apm code and enables some very basic apm output.
> We now get percentage (battery) output and basic time estimate.
> 
> Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> 
I munged it a bit by hand and checked it in.

> @@ -71,6 +79,8 @@ static irqreturn_t hp6x0_apm_interrupt(int irq, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> +extern void (*apm_get_power_status)(struct apm_power_info *);
> +
>  static int __init hp6x0_apm_init(void)
>  {
>  	int ret;

Note that this is superfluous, since the same definition exists in
include/linux/apm-emulation.h. You should also never be adding these
sorts of externs to C files in the first place.
