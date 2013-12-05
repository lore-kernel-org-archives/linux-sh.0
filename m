From: John Stultz <john.stultz@linaro.org>
Date: Thu, 05 Dec 2013 18:34:07 +0000
Subject: Re: [PATCH v3 02/03] ARM: shmobile: Remove CMT, TMU and STI Kconfig entries
Message-Id: <52A0C71F.1070906@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20131204203818.19090.92396.sendpatchset@w520> <20131204203837.19090.96622.sendpatchset@w520>
In-Reply-To: <20131204203837.19090.96622.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, tglx@linutronix.de

On 12/04/2013 12:38 PM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
>
> Now when drivers/clocksource/Kconfig has been
> updated with entires for CMT, TMU and STI
> it is safe to remove these from mach-shmobile.
>
> Also select timers per SoC via SYS_SUPPORTS_xxx.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Looks ok to me. Sorry for all the review pain on this.

For what its worth:
Acked-by: John Stultz <john.stultz@linaro.org>


