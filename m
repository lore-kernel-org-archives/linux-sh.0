From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 10 Sep 2018 20:34:49 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: fix clocksource width for 32-bit machines
Message-Id: <9d4d43f6-f85e-5ddb-a4cb-2b17925e255c@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
In-Reply-To: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-renesas-soc@vger.kernel.org
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, linux-sh@vger.kernel.org

On 09/10/2018 11:22 PM, Sergei Shtylyov wrote:

> The driver seems to abuse *unsigned long* not only for the (32-bit)
> register values but also for the 'sh_cmt_channel::total_cycles' which
> needs to always be 64-bit -- as a result, the clocksource's mask is
> needlessly clamped down to 32-bits on the 32-bit machines...

   I thought this bug was present from the start but no... 

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Fixes: 19bdc9d061bc ("clocksource: sh_cmt clocksource support")

[...]

MBR, Sergei
