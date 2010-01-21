From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Jan 2010 10:01:46 +0000
Subject: Re: [PATCH] spi_sh_msiof: Fixed data sampling on the correct edge
Message-Id: <aec7e5c31001210201v15047cd0xf03ad7d7e7855251@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Markus,

On Thu, Jan 21, 2010 at 6:26 PM, Pietrek, Markus
<Markus.Pietrek@emtrion.de> wrote:
> it seems to me that the spi_sh_msiof.c driver configures REDG and TEDG wrongly. TEDG=0 outputs data at the **rising edge** of the clock and REDG=0 samples data at the **falling edge** of the clock. Therefore for SPI, TEDG must be equal to REDG, otherwise the last byte received is not sampled in the SPI mode 3
>
> The SH7723 HW Reference Manual explains the setting in Figure 20.20 and Figure 20.21 ("SPI Clock and data timing")

Nice to hear that someone is using the msiof driver! Your patch, is it
for a theoretical data sheet mismatch issue only?

I used your version of the register settings initially when hacked up
the driver, but after testing on my sh7724 board and looking at the
results in a scope I decided to use the inverted bit setting. I may be
wrong though, so please back up your patch with some real world test
results. =)

/ magnus
