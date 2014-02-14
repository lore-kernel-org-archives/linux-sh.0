From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Feb 2014 01:57:50 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Add defconfig for shmobile mulitplatfom
Message-Id: <CANqRtoTT4iY4Bx_EFrXD810ygrXW8WyVN-f5ggnpDY0n1FqPWg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392337944-4000-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1392337944-4000-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Fri, Feb 14, 2014 at 9:32 AM, Simon Horman
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

Thanks for this! This shared defconfig looks like a good first step.

Regarding KZM9D, I believe the board is using a SMSC chip for
ethernet. Also EMEV2 is using EM_STI for timer. If you go decided to
make a V2 then can you please make sure those are included? We can
also deal with it incrementally.

Thanks,

/ magnus
