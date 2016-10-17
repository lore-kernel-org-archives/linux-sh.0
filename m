From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 17 Oct 2016 09:30:13 +0000
Subject: Re: [PATCH v9 0/2] J-Core timer support
Message-Id: <20161017093013.GA1703@mai>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1476393790.git.dalias@libc.org>
In-Reply-To: <cover.1476393790.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Oct 13, 2016 at 09:51:06PM +0000, Rich Felker wrote:
> This version of the patch makes the changes requested by Daniel
> Lezcano in review of v8.
> 
> Rich Felker (2):
>   of: add J-Core timer bindings
>   clocksource: add J-Core timer/clocksource driver
> 
>  .../devicetree/bindings/timer/jcore,pit.txt        |  24 ++
>  drivers/clocksource/Kconfig                        |  10 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/jcore-pit.c                    | 249 +++++++++++++++++++++
>  include/linux/cpuhotplug.h                         |   1 +
>  5 files changed, 285 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
>  create mode 100644 drivers/clocksource/jcore-pit.c

Hi Rich,

I applied your patches on my tree.

Thanks !

  -- Daniel
