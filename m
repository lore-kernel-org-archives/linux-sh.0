From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 06:16:46 +0000
Subject: Re: [PATCH 2/5] ARM: mach-shmobile: mackerel: Add SMSC support
Message-Id: <w3p8w0c4ptd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your check

> There is no EEPROM on this board? I guess so since you use
> SMSC911X_SAVE_MAC_ADDRESS.
> 
> I suspect that this code is not going to work with romImage since it
> depends on the boot loader for mac address.

Yes. mackerel doesn't have EEPROM for SMSC

> > +       gpio_request(GPIO_FN_CS5A,      NULL);
> > +       gpio_request(GPIO_FN_IRQ6_39,   NULL);
> > +
> 
> If you have time, please add code to setup optimized memory
> read/writing timings for the CS memory window here.

sorry.
What does this "optimized timings" mean ?


Best regards
--
Kuninori Morimoto
