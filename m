From: Mark Brown <broonie@kernel.org>
Date: Thu, 20 Aug 2020 21:48:32 +0000
Subject: Re: [PATCH v2 0/7] spi: rspi: Bit rate improvements
Message-Id: <159796010778.44514.12060590763849397055.b4-ty@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819125904.20938-1-geert+renesas@glider.be>
In-Reply-To: <20200819125904.20938-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org

On Wed, 19 Aug 2020 14:58:57 +0200, Geert Uytterhoeven wrote:
> 	Hi Mark,
> 
> This patch series contains several improvements for the Renesas SPI/QSPI
> driver related to bit rate configuration.
> 
> Changes compared to v1
> (https://lore.kernel.org/r/20200608095940.30516-1-geert+renesas@glider.be):
>   - Drop accepted patch.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/7] spi: rspi: Remove useless .set_config_register() check
      commit: 7ffe363bb2a25f0760127657f88243647f49bd5c
[2/7] spi: rspi: Clean up Bit Rate Division Setting handling
      commit: 8dd71698607f822c3675c366a8a79bc82f7621f8
[3/7] spi: rspi: Increase bit rate accuracy on RZ/A
      commit: feace90233a8cd44a18902216657279c3932d471
[4/7] spi: rspi: Increase bit rate range for RSPI on SH
      commit: 4e71d926abbe9ec23415f2ec8685a7bc26c1ceed
[5/7] spi: rspi: Increase bit rate range for QSPI
      commit: 6a195f24f3e88b9242268da79547fe4a61f30910
[6/7] spi: rspi: Fill in spi_transfer.effective_speed_hz
      commit: cb588254140802dbef0b29e4d0a1212cbe5e61e3
[7/7] spi: rspi: Fill in controller speed limits
      commit: c31979747b7090e8d255caecf5bb314436dd90ef

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
