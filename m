From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 Feb 2014 01:14:06 +0000
Subject: Re: [PATCH 0/3] add i2c support to genmai
Message-Id: <CANqRtoS64-9hYoVtpxZowM8Lc4vUn-oYJkG_aMpPT6ra_cc2rQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392671959-22834-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1392671959-22834-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 18, 2014 at 6:19 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Since I got renesas-devel-v3.14-rc3-20140217 to boot with r7s72100 again [1], I
> could now verify that this series in deed makes I2C2 work with the genmai
> board. The missing PFC patch can be added later once we have PFC support.
> Because I2C is the default pinmux setup, it already works without PFC. Please
> apply.
>
> [1] http://thread.gmane.org/gmane.linux.kernel/1649638

Thanks for breaking out the bits that are ready to merge.

> Wolfram Sang (3):
>   arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
>   arm: shmobile: genmai: adapt dts to use native i2c driver
>   ARM: shmobile: r7s72100: update defconfig for I2C usage

All look good to me. Thanks.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
