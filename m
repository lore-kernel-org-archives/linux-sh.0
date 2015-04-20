From: Kevin Hilman <khilman@kernel.org>
Date: Mon, 20 Apr 2015 23:21:23 +0000
Subject: Re: [RFC 0/5] PM / clock_ops: provide default runtime ops and cleanup users
Message-Id: <7hfv7ue68c.fsf@deeprootsystems.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1429018473-21865-1-git-send-email-rnayak@codeaurora.org>
	(Rajendra Nayak's message of "Tue, 14 Apr 2015 19:04:28 +0530")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: rjw@rjwysocki.net, ssantosh@kernel.org, tony@atomide.com, nsekhar@ti.com, magnus.damm@gmail.com, linux-arm-msm@vger.kernel.org, inux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org

Rajendra Nayak <rnayak@codeaurora.org> writes:

> Most users of PM clocks do the exact same thing in runtime callbacks.

Probably because they were all copied from mach-davinci. ;)

> Provide default callbacks and cleanup the existing users (keystone/davinci/omap1/sh)

Very nice cleanup, Thanks!

For the series:

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin
