From: David Miller <davem@davemloft.net>
Date: Thu, 11 Jun 2015 07:14:50 +0000
Subject: Re: [PATCH v6 1/2] Renesas Ethernet AVB driver proper
Message-Id: <20150611.001450.896536559764289809.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1890562.JASeYkKSbr@wasted.cogentembedded.com>
In-Reply-To: <1890562.JASeYkKSbr@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, richardcochran@gmail.com, linux-sh@vger.kernel.org, mitsuhiro.kimura.kc@renesas.com

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 11 Jun 2015 01:01:43 +0300

> Ethernet AVB includes an Gigabit Ethernet controller (E-MAC) that is basically
> compatible with SuperH Gigabit Ethernet E-MAC.  Ethernet AVB has  a  dedicated
> direct memory access controller (AVB-DMAC) that is a new design compared to the
> SuperH E-DMAC. The AVB-DMAC is compliant with 3 standards formulated for IEEE
> 802.1BA: IEEE 802.1AS timing and synchronization protocol, IEEE 802.1Qav real-
> time transfer, and the IEEE 802.1Qat stream reservation protocol.
> 
> The  driver only supports device tree probing, so the binding document is
> included in this patch.
> 
> Based on the original patches by Mitsuhiro Kimura.
> 
> Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
