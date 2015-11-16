From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 16 Nov 2015 20:30:53 +0000
Subject: Re: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
Message-Id: <20151116203053.GM8644@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <20151116181718.GW8644@n2100.arm.linux.org.uk>
 <HK2PR06MB056161DA1A57638A1D7305D58A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20151116195334.GL8644@n2100.arm.linux.org.uk>
 <HK2PR06MB0561019D9F96CF709040592C8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
In-Reply-To: <HK2PR06MB0561019D9F96CF709040592C8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Please wrap your messages at or before column 72, thanks.

On Mon, Nov 16, 2015 at 08:18:55PM +0000, Chris Brandt wrote:
> Maybe the only true solution is to have some additional XIP Kconfig
> option that tells the kernel to not copy any of the init or data
> sections at all at boot,

An XIP kernel will copy the .data section from ROM into RAM for you.
You don't need additional code external to the kernel to perfor this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
