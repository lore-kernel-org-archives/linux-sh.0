From: Ulf Hansson <ulf.hansson@stericsson.com>
Date: Tue, 13 Dec 2011 15:18:26 +0000
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
Message-Id: <4EE76CC2.9080308@stericsson.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Guennadi Liakhovetski wrote:
> Some MMC hosts implement a fine-grained runtime PM, whereby they
> runtime-suspend and -resume the host interface on each transfer. This can
> negatively affect performance, if the user was trying to transfer data
> blocks back-to-back. This patch adds a PM QoS constraint to avoid such a
> throughput reduction. This constraint prevents runtime-suspending the
> device, if the expected wakeup latency is larger than 100us.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I think host drivers can use autosuspend with some ms delay for this 
instead. This will mean that requests coming in bursts will not be 
affected (well only the first request in the burst will suffer from the 
runtime resume latency).

I believe that runtime resume callback should ofcourse be optimized so 
they are executed as fast as possible. But moreover, if they take more 
100us, is that really a reason for not executing them at all?

Br
Ulf Hansson
