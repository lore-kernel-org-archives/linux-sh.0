From: Mark Brown <broonie@kernel.org>
Date: Tue, 09 Jun 2020 12:54:47 +0000
Subject: Re: [PATCH 0/8] spi: rspi: Bit rate improvements
Message-Id: <159170728714.39829.17212206680435918911.b4-ty@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200608095940.30516-1-geert+renesas@glider.be>
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org

On Mon, 8 Jun 2020 11:59:32 +0200, Geert Uytterhoeven wrote:
> 	Hi Mark,
> 
> This patch series contains several improvements for the Renesas SPI/QSPI
> driver related to bit rate configuration.
> 
> This has been tested on RSK+RZA1 (RSPI) and R-Car M2-W/Koelsch (QSPI),
> using a scope and logic analyzer, except for the by-one divider on QSPI.
> This has not been tested on legacy SuperH, due to lack of hardware.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rspi: Use requested instead of maximum bit rate
      commit: e0fe70051f12c25c4afb04cb10ca8648c6e761cf

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
