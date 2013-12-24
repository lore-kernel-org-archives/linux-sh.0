From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Dec 2013 13:12:30 +0000
Subject: Re: [PATCH 1/2] spi: rspi: Fix NULL pointer dereference on SH7757
Message-Id: <20131224131230.GE30815@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, Hiep Cao Minh <cm-hiep@jinso.co.jp>

On Mon, Dec 23, 2013 at 07:34:23PM +0100, Geert Uytterhoeven wrote:
> SH7757 doesn't pass platform data, in which case spi-rspi uses default
> parameters.
> 
> However, commit 5ce0ba88650f2606244a761d92e2b725f4ab3583 ("spi: rcar: add
> Renesas QSPI support on RSPI") added a new user of the platform data, but
> forgot to check for its validity first, causing a NULL pointer dereference
> on SH7757.

Applied both, thanks.
