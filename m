From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 05 Sep 2018 20:27:09 +0000
Subject: [PATCH 0/2] Add R-Car gen3 SoC support to the CMT driver
Message-Id: <3ce24bfe-1edb-1a92-8847-ff998ac86d16@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Hello!

Here's the set of 2 patches against the 'tip.git' repo's 'timers/core' branch
plus the driver fixup for the 64-bit machines posted recently. We're adding
support for the CMT0 and CMT1 found in the R-Car gen3 SoCs.

[1/2] clocksource: sh_cmt: properly line-wrap sh_cmt_of_table[] initializer
[2/2] clocksource: sh_cmt: add R-Car gen3 support

MBR, Sergei
