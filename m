From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 13 Sep 2018 16:26:11 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: fix clocksource width for 32-bit machines
Message-Id: <3af7d095-0ac9-2fee-a030-1be796886938@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
 <e6f0e5e5-7c57-917b-98ce-80fe9242b292@linaro.org>
In-Reply-To: <e6f0e5e5-7c57-917b-98ce-80fe9242b292@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-renesas-soc@vger.kernel.org
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, linux-sh@vger.kernel.org

Hello!

On 09/13/2018 04:25 PM, Daniel Lezcano wrote:

>> The driver seems to abuse *unsigned long* not only for the (32-bit)
>> register values but also for the 'sh_cmt_channel::total_cycles' which
>> needs to always be 64-bit -- as a result, the clocksource's mask is
>> needlessly clamped down to 32-bits on the 32-bit machines...
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> This patch is against the 'tip.git' repo's 'timers/core' branch plus the fixup
>> for the 64-bit machines reposted last Saturday...
> 
> Why not against timers/urgent ?

   Mhm... nothing blows up because of this apparently (the bug is quite old).

MBR, Sergei
