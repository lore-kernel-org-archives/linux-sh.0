From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2015 22:41:33 +0000
Subject: Re: [PATCH v3] Renesas Ethernet AVB driver
Message-Id: <20150422.184133.132510003688162502.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <553814F0.40405@cogentembedded.com>
	<20150422.181813.1931455043058560592.davem@davemloft.net>
	<553821F8.8050300@cogentembedded.com>
In-Reply-To: <553821F8.8050300@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: mitsuhiro.kimura.kc@renesas.com, f.fainelli@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, richardcochran@gmail.com, linux-sh@vger.kernel.org, masaru.nagai.vx@renesas.com

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 23 Apr 2015 01:34:32 +0300

>    Sigh... I'm seeing no way out of that then, only copying. :-(

What exactly is the device's restriction?

Any reasonable modern chip allows one of two things.

Either it allows arbitrary alignment of the start of the TX
frame when DMA'ing.

_or_

It allows a variable number of pad bytes to be inserted by the
driver before giving it to the card, which do not go onto the
wire, in order to meet the device's DMA restrictions.

For example, if the packet is only 2 byte aligned, you set the "ignore
offset" to 2 and push two zero bytes in front of the ethernet frame
before giving it to the card.

If a chip made in this day and era cannot do one of those two things,
this is beyond disappointing and is a massive engineering failure.
Whoever designed this chip made no investigation into how their
hardware is going to be actually used.
