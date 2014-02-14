From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Feb 2014 09:07:16 +0000
Subject: Re: [PATCH v4] ARM: shmobile: Add defconfig for shmobile mulitplatfom
Message-Id: <CANqRtoT5C432uQF6yG76PeMopF7HfqQDSyJ5SMF_77RsyC9DxA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392354403-30260-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1392354403-30260-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 14, 2014 at 2:06 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> This is intended to be a base for a defconfig to cover all
> shmobile multiplatform boards. It currently includes configuration
> for the following boards:
>
> * KZM9D
> * Lager
> * Koelsch
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> v4
> * Account for removal of CONFIG_KZM9D
>   - Do not select CONFIG_MACH_KZM9D
>   - Select CONFIG_SMSC_PHY and CONFIG_REGULATOR_FIXED_VOLTAGE

Thanks Simon!

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
