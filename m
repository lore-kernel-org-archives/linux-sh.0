From: santosh shilimkar <santosh.shilimkar@oracle.com>
Date: Mon, 20 Apr 2015 23:25:25 +0000
Subject: Re: [RFC 0/5] PM / clock_ops: provide default runtime ops and cleanup users
Message-Id: <55358AE5.1070900@oracle.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org> <7hfv7ue68c.fsf@deeprootsystems.com>
In-Reply-To: <7hfv7ue68c.fsf@deeprootsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Hilman <khilman@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>
Cc: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, nsekhar@ti.com, magnus.damm@gmail.com, linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

On 4/20/2015 4:21 PM, Kevin Hilman wrote:
> Rajendra Nayak <rnayak@codeaurora.org> writes:
>
>> Most users of PM clocks do the exact same thing in runtime callbacks.
>
> Probably because they were all copied from mach-davinci. ;)
>
Yep. ;-)

>> Provide default callbacks and cleanup the existing users (keystone/davinci/omap1/sh)
>
> Very nice cleanup, Thanks!
>
Indeed !!
I can't test it out but from the series, I don't expect anything
to break. So looks good to me as well.

> For the series:
>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
