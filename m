From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jan 2014 08:44:56 +0000
Subject: Re: [PATCH CFT] ARM:SHMOBILE: Enable AUTO_ZRELADDR by default
Message-Id: <CANqRtoSko2Ctwkq-Q8TTLmkjNQPFi5CPxyvHt_NSxq4qBAX+BQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389256274-6308-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
In-Reply-To: <1389256274-6308-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 9, 2014 at 5:31 PM, panchaxari
<panchaxari.prasannamurthy@linaro.org> wrote:
> This patch enables AUTO_ZRELADDR as default config to Renasas R-Mobile and
> SH-Mobile platforms.
>
> AUTO_ZRELADDR config enables auto calculation of the decompressed kernel image
> address. AUTO_ZRELADDR config is mutually exclusive to ZBOOT_ROM, and also
> assumes zImage to be loaded in the first 128MiB from start of memory.
>
> CFT::Call For Testing
>
> Requesting maintainers of R-Mobile and SH-Mobile platforms to evaluate the
> changes on the board and comment, as I dont have the board for testing, and
> also requesting an ACK.
>
> Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>

Thanks for the patch. I believe we enable this for the multiplatform
case already. The legacy case still supports ZBOOT_ROM and boards that
don't work with AUTO_ZRELADDR, so because of this we intentionally
don't enable it there.

What is the reason you want to add it here?

Thanks,

/ magnus
