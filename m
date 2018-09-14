From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 14 Sep 2018 14:33:36 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: fix clocksource width for 32-bit machines
Message-Id: <35868211-4202-2ca2-425e-ac712e45bf59@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
In-Reply-To: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Thomas Gleixner <tglx@linutronix.de>, linux-renesas-soc@vger.kernel.org
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, linux-sh@vger.kernel.org

On 10/09/2018 22:22, Sergei Shtylyov wrote:
> The driver seems to abuse *unsigned long* not only for the (32-bit)
> register values but also for the 'sh_cmt_channel::total_cycles' which
> needs to always be 64-bit -- as a result, the clocksource's mask is
> needlessly clamped down to 32-bits on the 32-bit machines...
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---

Applied for 4.20, thanks.
