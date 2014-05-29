From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 29 May 2014 16:01:40 +0000
Subject: Re: [PATCH 5/7] ARM: dts: r8a7791-koelsch: Add DVFS parameters into cpu0 node for r8a7791
Message-Id: <538759E4.7000304@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E681.4070107@bp.renesas.com>
In-Reply-To: <5386E681.4070107@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/29/2014 11:49 AM, Gaku Inami wrote:

> Add needed information inside CPU0 for the generic cpufreq-cpu0 driver.

> - voltage-tolerance = 1%
>    It reflects the tolerance for the CPU voltage defined inside the OPP
>    table. Due to the lack of proper OPP definition, use an arbitrary safe
>    value.
> - clock-latency = 300 us
>    Approximate worst-case latency to do a full DVFS transition for every
>    OPPs. Due to the lack of HW information, use an arbitrary safe value.
>    Note: The term transition-latency will be more accurate to define this
>    value since the clock transition latency is not the only parameter that
>    will define the overall DVFS transition.
> - operating-points = < kHz - uV >
>    List of 6 operating points. All of them are using the same voltage
>    since DVS is not supported in R-CAR Gen2.
> - clocks
>    phandle to the CPU clock source. This clock source is used for all the
>    2 CortexA15 located inside the same cluster.

> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---
>   arch/arm/boot/dts/r8a7791.dtsi |   11 +++++++++++
>   1 file changed, 11 insertions(+)

   You're not touching the Koelsch code in this patch, why mention the board
name in the subject?

WBR, Sergei

