From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Mar 2015 02:05:26 +0000
Subject: Re: [PATCH V2] ARM: shmobile: cpuidle: Remove the pointless default driver
Message-Id: <20150319020526.GL14051@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1426605912-28032-1-git-send-email-daniel.lezcano@linaro.org>
 <550847BA.8050503@linaro.org>
In-Reply-To: <550847BA.8050503@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 17, 2015 at 04:26:50PM +0100, Daniel Lezcano wrote:
> 
> Sorry Geert, I forget to Cc you.
> 
> On 03/17/2015 04:25 PM, Daniel Lezcano wrote:
> >The default idle driver uses one state with the WFI instruction.
> >The default idle routine invokes WFI when no cpuidle driver is present.
> >
> >The default cpuidle driver is pointless and does not give more than the
> >default idle routine and moreover it pulls all the mathematics tied with
> >the cpuidle governor for nothing, hence consuming more energy.
> >
> >Remove the default driver, the related code and register the driver directly.
> >
> >[compiled only - no board - no test]
> >
> >Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel,

I have queued this up for v4.1.
