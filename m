From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2015 20:42:42 +0000
Subject: Re: [PATCH v3] Renesas Ethernet AVB driver
Message-Id: <20150422.164242.2185477513394713122.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <SIXPR06MB03142A49C392C39922DC2BDA3EE0@SIXPR06MB031.apcprd06.prod.outlook.com>
	<20150422.113654.1169277303695917496.davem@davemloft.net>
	<553804CA.1030605@cogentembedded.com>
In-Reply-To: <553804CA.1030605@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: mitsuhiro.kimura.kc@renesas.com, f.fainelli@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, richardcochran@gmail.com, linux-sh@vger.kernel.org, masaru.nagai.vx@renesas.com

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 22 Apr 2015 23:30:02 +0300

>    Hmm, I've been digging in the net core, and was unable to see where TX
>    skb's get their NET_IP_ALIGN bytes reserved. Have I missed something?
>    Probably need to print out skb's fields...

NET_IP_ALIGN is for receive, not transmit.
