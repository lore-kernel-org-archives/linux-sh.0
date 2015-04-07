From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Tue, 07 Apr 2015 05:56:42 +0000
Subject: Re: [RFC/PATCH 2/4] ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
Message-Id: <5523719A.7060301@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428292244-2160-3-git-send-email-keita.kobayashi.ym@renesas.com>
In-Reply-To: <1428292244-2160-3-git-send-email-keita.kobayashi.ym@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

Thank you for your feedback.

(2015/04/07 10:50), Simon Horman wrote:

> On Mon, Apr 06, 2015 at 12:50:42PM +0900, Keita Kobayashi wrote:
>> This patch add Core-Standby support for R-Car cpuidle.
>>
>> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> 
> [snip]
> 
>> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
>> index 6815781..846b8ae 100644
> 
> [snip]
> 
>> +struct cpuidle_ops rcar_cpuidle_ops __initdata = {
>> +	.suspend = rcar_cpuidle_enter,
>> +};
>> +CPUIDLE_METHOD_OF_DECLARE(rcar, "renesas,rcar-idle", &rcar_cpuidle_ops);
>> +#endif
> 
> It seems to me that that renesas,rcar-idle should be documented
> as an enable-method in Documentation/devicetree/bindings/arm/cpus.txt.
> 
> That change could be a separate patch for device tree.

I understand. I will document it.

Regards.
Keita Kobayashi
