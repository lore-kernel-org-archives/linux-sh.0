From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 05:34:22 +0000
Subject: [PATCH v8 0/2] J-Core timer support
Message-Id: <cover.1475990489.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Resubmitted with the (incorrect) workaround for rcu_sched stalls
removed, since the problem was found in the interrupt controller
driver; a separate patch will be submitted for it.

Rich Felker (2):
  of: add J-Core timer bindings
  clocksource: add J-Core timer/clocksource driver

 .../devicetree/bindings/timer/jcore,pit.txt        |  24 +++
 drivers/clocksource/Kconfig                        |  10 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/jcore-pit.c                    | 231 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 5 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
 create mode 100644 drivers/clocksource/jcore-pit.c

-- 
2.10.0

