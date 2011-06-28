From: David Miller <davem@davemloft.net>
Date: Tue, 28 Jun 2011 01:38:44 +0000
Subject: Re: [PATCH v2] NET: AX88796: Tighten up Kconfig dependencies
Message-Id: <20110627.183844.146129637361136342.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20110627111259.GA13620@linux-mips.org>
	<BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
In-Reply-To: <BANLkTikDxsOJKpiJs0NpMXbjVOFMHL7RZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 09:40:56 +0900

> As for SH and SH-Mobile ARM, unless explicitly requested we usually
> don't restrict our platform drivers. Allowing them to build on any
> system helps to catch compile errors.

I totally agree with Magnus, drivers should build on as many systems
as possible.  Even on those for which the hardware never appears.

Ralf, unless these drivers have unfixable build errors on MIPS I
do not want to add the new restrictions.
