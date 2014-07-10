From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Jul 2014 08:23:55 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <CANqRtoQF9bQmpz6wo9KPDC+raDnuYT-B+d4edAPE0gxsDav5wQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53B5F327.5040301@renesas.com>
In-Reply-To: <53B5F327.5040301@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san, Wolfram, everyone,

[CC Wolfram]

On Fri, Jul 4, 2014 at 2:19 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> I2C bus for VDD MPU regulator is IIC3, not I2C3.
>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> ---
> v2:
>   - re-based on top of tag renesas-devel-v3.16-rc3-20140701.
>   - removed redundant spaces.

This patch is changing I2C master controller device for the I2C bus
where the power chip is located. I've heard that all of our different
I2C controllers come with a range of features and issues, so I think
we should check with the I2C maintainer Wolfram Sang about this
matter.

Wolfram, can you give us your opinion about this patch? Does it
improve our I2C software support on Lager?

Khiem-san, in the future please CC Wolfram about issues related to I2C.

Thanks,

/ magnus
