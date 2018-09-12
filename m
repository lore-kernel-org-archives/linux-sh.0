From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Sep 2018 20:10:26 +0000
Subject: [PATCH v2 0/3] Add R-Car gen3 SoC support to the CMT driver
Message-Id: <c94a4ad6-93ee-05e4-e2c1-e8d24d3bc75e@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Hello!

Here's the set of 3 patches against the 'tip.git' repo's 'timers/core' branch
plus the CMT driver fixups for the 32/64-bit machines posted recently. We're
adding support for the CMT types0/1 found in the R-Car gen3 SoCs.

[1/3] clocksource: sh_cmt: properly line-wrap sh_cmt_of_table[] initializer
[2/3] dt-bindings: timer: renesas: cmt: document R-Car gen3 support
[3/3] clocksource: sh_cmt: add R-Car gen3 support

MBR, Sergei
