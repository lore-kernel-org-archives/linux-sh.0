From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 16 Nov 2015 19:53:34 +0000
Subject: Re: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
Message-Id: <20151116195334.GL8644@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <20151116181718.GW8644@n2100.arm.linux.org.uk>
 <HK2PR06MB056161DA1A57638A1D7305D58A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
In-Reply-To: <HK2PR06MB056161DA1A57638A1D7305D58A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 16, 2015 at 07:46:05PM +0000, Chris Brandt wrote:
> > We don't need the data sections because they will have been copied to RAM, and
> > we probably don't want to keep those exposed (it's potentially useful for
> > attackers.)
> 
> The init sections also hang around after boot as well (it's XIP code, so
> there is nothing to 'free' in terms of executable init code).
> Any potential security issues there as well? Should the data and init-
> text sections be put in a separate section that gets blown away after
> init-data is freed?

That's much harder to do - generally for XIP, people are space limited
(which is why they're using XIP rather than putting the kernel in RAM.)
They won't take kindly to having the kernel image bloated by 1MB just
to pad it out so that the init stuff can be unmapped.

However, from the security point of view, the less that's mapped at
known addresses, the better.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
