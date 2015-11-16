From: Chris Brandt <Chris.Brandt@renesas.com>
Date: Mon, 16 Nov 2015 21:09:43 +0000
Subject: RE: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
Message-Id: <HK2PR06MB05611F9340E9EA5AD36916408A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <20151116181718.GW8644@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511161550370.5826@knanqh.ubzr>
In-Reply-To: <alpine.LFD.2.20.1511161550370.5826@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> If the section mapping extends to part of the ROM that is no longer
> kernel data then maybe this would expose sensitive data.  Is that
> what you're worried about?

That is a good point that I did not consider before. Thank you.

Chris

