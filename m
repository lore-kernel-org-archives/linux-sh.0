From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Tue, 08 Sep 2015 09:07:09 +0000
Subject: Re: [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X
Message-Id: <55EEA53D.3090203@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150908044957.4919.98690.sendpatchset@little-apple>
In-Reply-To: <20150908044957.4919.98690.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

> To make things slightly more complicated it seems that some boards use
> 16.6666 MHz and others 16.0 Mhz...
AFAIK, the 16.0 Mhz is only available in some initial Salvator-X boards.
So, 16.6666 MHz should be standard value, I guess.

