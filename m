From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Apr 2014 07:35:45 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable USB [EO]HCI HCD support in shmobile_defconfig
Message-Id: <CANqRtoQ8-zRY1eCTF9uDzWi+dCaKPBdnmhTrOL8UgztHcVMj7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397115230-18437-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1397115230-18437-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, Apr 10, 2014 at 4:33 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The USB [EO]HCI HCD drivers provide USB host support for Renesas
> R-Car Gen2 platforms. To increase hardware support enable the driver in the
> shmobile_defconfig multiplatform configuration.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, this configuration is useful for both DT and platform device support.

Acked-by: Magnus Damm <damm@opensource.se.>

/ magnus
