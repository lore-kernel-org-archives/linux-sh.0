From: Rich Felker <dalias@libc.org>
Date: Mon, 03 Oct 2016 22:10:39 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161003221039.GR19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
In-Reply-To: <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> On 26/09/2016 23:07, Rich Felker wrote:
> > Ping. Is there anything that still needs to be changed for this driver
> > to be acceptable?
> 
> It is on my radar. I'm reviewing it.
> 
> Can you elaborate the workaround mentioned in the changelog. I have been
> digging into the lkml@ thread but it is not clear if the issue is
> related to the time framework, the driver itself or whatever else. Can
> you clarify that ?

Do you have comments on any remaining issues other than this
workaround? If not I don't mind removing the workaround and trying to
solve the issue separately later. Let me know and either way I'll
submit a v8.

Rich
